// model for login authorization requests from Swift app

struct LoginRequest : Codable {
    let email: String
    let password: String
}
