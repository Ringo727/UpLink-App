package main

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"strings"

	"github.com/jackc/pgx/v5/pgxpool"
)

func loginHandler(w http.ResponseWriter, r *http.Request) {
	var user User
	if err := json.NewDecoder(r.Body).Decode(&user); err != nil {
		http.Error(w, "Invalid JSON", http.StatusBadRequest)
		return
	}

	email := strings.ToLower(strings.TrimSpace(user.Email))
	if !emailRegex.MatchString(email) {
		http.Error(w, "Invalid email format", http.StatusBadRequest)
		return
	}

	// TODO: Lookup user by email in DB
	// Example:
	// dbUser, err := GetUserByEmail(email)
	// if err != nil { ... }

	// TODO: Compare password with bcrypt.CompareHashAndPassword

	// TODO: Create session or return token

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(map[string]string{
		"message": "User logged in successfully",
	})
}

func registerHandler(db *pgxpool.Pool) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		// steps:
		// 1. decode jSON into user struct style
		// 2. validate password and maybe email and username
		// 3. hash password
		// 4. save to DB
		// 5. send OK or ERROR response

		fmt.Println("Registering user...")

		var user User
		if err := json.NewDecoder(r.Body).Decode(&user); err != nil {
			http.Error(w, "Invalid JSON", http.StatusBadRequest)
			fmt.Println("ERROR: Invalid JSON")
			return
		}

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

		fmt.Println("adding user to database...")
		ctx := context.Background()

		_, err = db.Exec(ctx,
			`INSERT INTO users (username, email, password_hash)
		 VALUES ($1, $2, $3)`, cleanedUsername, cleanedEmail, hashed)

		if err != nil {
			http.Error(w, "Database error: "+err.Error(), http.StatusInternalServerError)
			fmt.Println("ERROR: ", err.Error())
			return
		}

		fmt.Println("cleanedEmail: ", cleanedEmail)
		fmt.Println("cleanedUsername: ", cleanedUsername)
		fmt.Println("hashed: ", hashed)
		fmt.Println("unhashed: ", user.Password) // FOR TESTING ONLY

		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		json.NewEncoder(w).Encode(map[string]string{
			"message": "User registered successfully",
		})
	}
}
