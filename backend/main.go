package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {

	// password := "goongoongoongoongoonsahur123"

	http.HandleFunc("/login", loginHandler)
	fmt.Println("Server started on http://localhost:8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
