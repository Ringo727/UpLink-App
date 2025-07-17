package main

import (
	"context"
	"fmt"
	// "github.com/Ringo727/UpLink-App/handlers"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/joho/godotenv"
	"log"
	"net/http"
	"os"
)

func main() {
	envErr := godotenv.Load()
	if envErr != nil {
		fmt.Println("No env file found or error while loading; switching to system environment variables")
	}

	fmt.Println("Database URL: ", os.Getenv("DATABASE_URL"))

	dbpool, err := pgxpool.New(context.Background(), os.Getenv("DATABASE_URL"))
	if err != nil {
		fmt.Fprintf(os.Stderr, "Unable to create connection pool: %v\n", err)
		os.Exit(1)
	}

	ctx := context.Background()

	var result int
	err = dbpool.QueryRow(ctx, "SELECT 1").Scan(&result)
	if err != nil {
		log.Fatalf("Database connection test failed: %v", err)
	}
	fmt.Println("Database connection test succeeded:", result)

	defer dbpool.Close()

	r := chi.NewRouter()

	r.Use(middleware.Logger)
	r.Use(middleware.Recoverer)

	r.Post("/api/login", loginHandler)
	r.Post("/api/register", registerHandler(dbpool))

	fmt.Println("Server started on http://localhost:8080")
	log.Fatal(http.ListenAndServe(":8080", r))
}
