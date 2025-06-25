package main

import (
	"fmt"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"log"
	"net/http"
)

func main() {
	r := chi.NewRouter()

	r.Post("/login", loginHandler)
	r.Post("/register", registerHandler)

	r.Use(middleware.Logger)
	r.Use(middleware.Recoverer)

	fmt.Println("Server started on http://localhost:8080")
	log.Fatal(http.ListenAndServe(":8080", r))
}
