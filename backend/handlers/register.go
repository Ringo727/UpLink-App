// soon, this will hold the register handler. right now, i'm having issues with getting it to work, so it is temporarily
// commented out and will be fixed later.
package handlers

// import (
// 	"context"
// 	"encoding/json"
// 	"fmt"
// 	"net/http"

// 	"github.com/jackc/pgx/v5/pgxpool"
// )

// func registerHandler(db *pgxpool.Pool) http.HandlerFunc {
// 	return func(w http.ResponseWriter, r *http.Request) {
// 		// steps:
// 		// decode jSON into user struct style
// 		// validate password and maybe email and username
// 		// hash password
// 		// save to DB (dunno how this works atm)
// 		// send OK or ERROR response

// 		var user User
// 		if err := json.NewDecoder(r.Body).Decode(&user); err != nil {
// 			http.Error(w, "Invalid JSON", http.StatusBadRequest)
// 			return
// 		}

// 		cleanedEmail, err := validateEmail(user.Email)
// 		if err != nil {
// 			http.Error(w, err.Error(), http.StatusBadRequest)
// 			return
// 		}

// 		cleanedUsername, err := validateUsername(user.Username)
// 		if err != nil {
// 			http.Error(w, err.Error(), http.StatusBadRequest)
// 			return
// 		}

// 		if err := validatePassword(user.Password); err != nil {
// 			http.Error(w, err.Error(), http.StatusBadRequest)
// 			return
// 		}

// 		hashed, err := hashPassword(user.Password)
// 		if err != nil {
// 			http.Error(w, "Error hashing password", http.StatusInternalServerError)
// 			return
// 		}

// 		ctx := context.Background()
// 		_, err = db.Exec(ctx,
// 			`INSERT INTO users (username, email, password_hash)
// 		 VALUES ($1, $2, $3)`, cleanedUsername, cleanedEmail, hashed)

// 		// TODO: Save cleanedUsername, cleanedEmail, and hashedPassword to DB
// 		fmt.Println("cleanedEmail: ", cleanedEmail)
// 		fmt.Println("cleanedUsername: ", cleanedUsername)
// 		fmt.Println("hashed: ", hashed)
// 		fmt.Println("unhashed: ", user.Password) // FOR TESTING ONLY

// 		w.Header().Set("Content-Type", "application/json")
// 		w.WriteHeader(http.StatusOK)
// 		json.NewEncoder(w).Encode(map[string]string{
// 			"message": "User registered successfully",
// 		})
// 	}
// }
