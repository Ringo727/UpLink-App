package main

import (
	"encoding/json"
	// "fmt"
	"net/http"
)

func loginHandler(w http.ResponseWriter, r *http.Request) {
	// debugging
	// fmt.Println("Reached login handler")

	// makes sure only logging in using a POST request from HTTP
	if r.Method != http.MethodPost {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		return
	}

	var user User
	if err := json.NewDecoder(r.Body).Decode(&user); err != nil {
		http.Error(w, "Invalid JSON", http.StatusBadRequest)
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

	w.WriteHeader(http.StatusOK)
	// REMOVE AFTER TESTING; NEVER SEND HASH BACK TO USER
	// w.Write([]byte("Password hashed successfully: " + hashed))
}
