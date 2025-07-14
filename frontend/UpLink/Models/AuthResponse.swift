// model for authorization responses from server
// examples: sign up/login responses

struct AuthResponse : Codable {
    let message : String
    // maybe more later? (token ?)
}
