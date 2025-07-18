package main

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"strings"

	"github.com/jackc/pgx/v5/pgxpool"
	"golang.org/x/crypto/bcrypt"
)

func loginHandler(db *pgxpool.Pool) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		fmt.Println("Logging in user...")

		var user User
		if err := json.NewDecoder(r.Body).Decode(&user); err != nil {
			http.Error(w, "Invalid JSON", http.StatusBadRequest)
			fmt.Println("ERROR: Invalid JSON")
			return
		}

		email := strings.ToLower(strings.TrimSpace(user.Email))
		if !emailRegex.MatchString(email) {
			http.Error(w, "Invalid email format", http.StatusBadRequest)
			fmt.Println("ERROR: invalid email format")
			return
		}

		// TODO: extract into a helper function for easy reusability

		// get password currently stored in the database
		var storedHash string
		ctx := context.Background()
		err := db.QueryRow(ctx,
			`SELECT password_hash FROM users WHERE email=$1`, email).Scan(&storedHash)
		if err != nil {
			http.Error(w, "Database error: "+err.Error(), http.StatusInternalServerError)
			fmt.Println("ERROR: ", err.Error())
			return
		}

		// compare password from HTTP request and stored password in the database
		if err := bcrypt.CompareHashAndPassword([]byte(storedHash), []byte(user.Password)); err != nil {
			http.Error(w, "Incorrect password", http.StatusBadRequest)
			fmt.Println("Incorrect password")
			return
		}

		fmt.Println("Successfully logged in user!")

		// TODO: Create session or return token ?

		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		json.NewEncoder(w).Encode(map[string]string{
			"message": "User logged in successfully",
		})
	}
}

// handles registration of a user on the sign up screen
// param: database pool connection from pgx (postgres library)
func registerHandler(db *pgxpool.Pool) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		fmt.Println("Registering user...")

		// decode json into a user struct model
		var user User
		if err := json.NewDecoder(r.Body).Decode(&user); err != nil {
			http.Error(w, "Invalid JSON", http.StatusBadRequest)
			fmt.Println("ERROR: Invalid JSON")
			return
		}

		// check email, username, and password for requirements
		cleanedEmail, err := validateEmail(user.Email)
		if err != nil {
			http.Error(w, err.Error(), http.StatusBadRequest)
			fmt.Println("ERROR: ", err.Error())
			return
		}

		cleanedUsername, err := validateUsername(user.Username)
		if err != nil {
			http.Error(w, err.Error(), http.StatusBadRequest)
			fmt.Println("ERROR: ", err.Error())
			return
		}

		if err := validatePassword(user.Password); err != nil {
			http.Error(w, err.Error(), http.StatusBadRequest)
			fmt.Println("ERROR: ", err.Error())
			return
		}

		hashed, err := hashPassword(user.Password)
		if err != nil {
			http.Error(w, "Error hashing password", http.StatusInternalServerError)
			fmt.Println("ERROR: ", err.Error())
			return
		}

		// TODO: check if user is already in database
		// ex - username already in use, email already in use

		// TODO: extract into a helper function for easy reusability
		// insert user into database
		ctx := context.Background()
		_, err = db.Exec(ctx,
			`INSERT INTO users (username, email, password_hash)
		 VALUES ($1, $2, $3)`, cleanedUsername, cleanedEmail, hashed)

		if err != nil {
			http.Error(w, "Database error: "+err.Error(), http.StatusInternalServerError)
			fmt.Println("ERROR: ", err.Error())
			return
		}

		fmt.Println(cleanedUsername + " successfully registered")

		// send HTTP response
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		json.NewEncoder(w).Encode(map[string]string{
			"message": "User registered successfully",
		})
	}
}
