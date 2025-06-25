package main

import (
	"errors"
	"github.com/TwiN/go-away"
	"golang.org/x/crypto/bcrypt"
	"net"
	"regexp"
	"strings"
	"unicode/utf8"
)

// Global regexp variables to avoid reinitialization for function calls
var (
	emailRegex      = regexp.MustCompile(`^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$`)
	usernameRegex   = regexp.MustCompile(`^[a-z0-9._]+$`)
	upperRegex      = regexp.MustCompile(`[A-Z]`)
	lowerRegex      = regexp.MustCompile(`[a-z]`)
	numberRegex     = regexp.MustCompile(`[0-9]`)
	symbolRegex     = regexp.MustCompile(`[!@#\$%\^&\*\(\)_\+\-=\[\]{}\|;:,.<>\/\?]`)
	allowedPwdRegex = regexp.MustCompile(`^[a-zA-Z0-9!@#\$%\^&\*\(\)_\+\-=\[\]{}\|;:,.<>\/\?]+$`)
)

// Email Validation Function
func validateEmail(email string) (string, error) {
	email = strings.ToLower(strings.TrimSpace(email))

	if !emailRegex.MatchString(email) {
		return "", errors.New("Email format is invalid")
	}

	parts := strings.Split(email, "@")
	if len(parts) != 2 {
		return "", errors.New("Email must contain a single '@' symbol")
	}

	domain := parts[1]
	if !domainHasMX(domain) {
		return "", errors.New("Email domain appears to be invalid or not accepting mail")
	}

	// TODO: Make final check to see if email exists in database already
	// TODO: Generate confirmation token and send confirmation email

	return email, nil
}

// Check for if domain is real
func domainHasMX(domain string) bool {
	_, err := net.LookupMX(domain)
	return err == nil
}

// Username Validation Function
func validateUsername(username string) (string, error) {
	// Usernames are normalized to lowercase before validation
	username = strings.ToLower(strings.TrimSpace(username))

	if len(username) < 2 || len(username) > 32 {
		return "", errors.New("Username must be between 2 and 32 characters")
	}

	if !usernameRegex.MatchString(username) {
		return "", errors.New("Username can only contain lowercase letters, numbers 0 through 9, and periods")
	}

	// Profanity Check
	if goaway.IsProfane(username) {
		return "", errors.New("Username contains inappropriate or offensive words")
	}

	// TODO: Make final check to see if username exists in the database

	return username, nil
}

// Password Validation Function
func validatePassword(password string) error {
	// Emojis or non-ASCII char can inflate byte count even if disallowed; prevents accidental over-rejection of multi-byte characters
	// length := len([]byte(password))
	length := utf8.RuneCountInString(password)

	if length > 64 {
		return errors.New("Password too long - must be 64 characters or less")
	}
	if length < 8 {
		return errors.New("Password too short - must be 8 characters or more")
	}

	if !(upperRegex.MatchString(password) &&
		lowerRegex.MatchString(password) &&
		numberRegex.MatchString(password) &&
		symbolRegex.MatchString(password)) {
		return errors.New("Password must include at least one uppercase letter, one lowercase letter, one number, and one allowed symbol")
	}

	if !allowedPwdRegex.MatchString(password) {
		return errors.New("Password contains invalid characters")
	}

	return nil
}

// Password Hashing Function
func hashPassword(password string) (string, error) {
	hash, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		return "", err
	}
	return string(hash), nil
}
