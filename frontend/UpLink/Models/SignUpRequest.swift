// model for sign up authorization requests from Swift app

struct SignUpRequest : Codable {
    let username: String
    let email: String
    let password: String
}
