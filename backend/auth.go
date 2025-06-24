package main

import (
	"errors"
	"golang.org/x/crypto/bcrypt"
	"log"
	"regexp"
)

func validateUsername(username string) error {

	if len(username) < 3 || len(username) > 20 {
		return errors.New("Username must be between 3 and 20 characters")
	}

	matched, err := regexp.MatchString(`^[a-zA-Z0-9_]+$`, username)
	if err != nil {
		return errors.New("Server error while validating username")
	}

	if !matched {
		return errors.New("Username can only contain letters, numbers, and underscores")
	}

	// TODO: Make final check to see if username exists in the database

	return nil
}

func validatePassword(password string) error {
	length := len([]byte(password))

	if length > 64 {
		return errors.New("Password too long - must be 64 characters or less")
	} else if length < 8 {
		return errors.New("Password too short - must be 8 characters or more")
	}
	return nil
}

func hashPassword(password string) (string, error) {
	hash, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		log.Fatal(err)
	}
	return string(hash), nil
}
