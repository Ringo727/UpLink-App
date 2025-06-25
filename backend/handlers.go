package main

import (
	"encoding/json"
	// "fmt"
	"net/http"
	"strings"
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

	w.WriteHeader(http.StatusOK)
	w.Write([]byte("Logged in successfully"))
}

func registerHandler(w http.ResponseWriter, r *http.Request) {
	// steps:
	// decode jSON into user struct style
	// validate password and maybe email and username
	// hash password
	// save to DB (dunno how this works atm)
	// send OK or ERROR response

	var user User
	if err := json.NewDecoder(r.Body).Decode(&user); err != nil {
		http.Error(w, "Invalid JSON", http.StatusBadRequest)
		return
	}

	cleanedEmail, err := validateEmail(user.Email)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	cleanedUsername, err := validateUsername(user.Username)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	if err := validatePassword(user.Password); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	hashed, err := hashPassword(user.Password)
	if err != nil {
		http.Error(w, "Error hashing password", http.StatusInternalServerError)
		return
	}

	// TODO: Save cleanedUsername, cleanedEmail, and hashedPassword to DB

	w.WriteHeader(http.StatusOK)
	w.Write([]byte("User registered successfully"))
}
