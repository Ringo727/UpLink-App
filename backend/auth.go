package main

import (
	"errors"
	"golang.org/x/crypto/bcrypt"
	"log"
)

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
