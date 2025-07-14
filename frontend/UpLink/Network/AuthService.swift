import Foundation

// NOTE: urlString and baseURL are temporary - must be changed to the actual server's url upon deployment
let urlString = "http://localhost:8080/api/"
let baseURL = URL(string: urlString)

// registers a user with the given parameter values by sending a POST request to the server, which will then perform the backend actions necessary, then return a response
func registerUser(username: String, email: String, password: String) {
    guard let url = baseURL?.appendingPathComponent("register") else {
        print("invalid registration url")
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let authRequest = SignUpRequest(username: username, email: email, password: password)

    do {
        request.httpBody = try JSONEncoder().encode(authRequest)
    } catch {
        print("error while encoding JSON body: ", error)
        return
    }

    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("request error: ", error)
            return
        }

        guard let data = data else {
            print("no data in response")
            return
        }

        do {
            let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
            print("registration response: ", authResponse.message)
        } catch {
            print("unable to decode response: ", error)
        }
    }.resume()
}

// sends a POST request to the server with an email and password as login information - the server then attempts to login and returns a response
func loginUser(email: String, password: String) {
    guard let url = baseURL?.appendingPathComponent("login") else {
        print("invalid registration url")
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let authRequest = LoginRequest(email: email, password: password)

    do {
        request.httpBody = try JSONEncoder().encode(authRequest)
    } catch {
        print("error while encoding JSON body: ", error)
        return
    }

    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("request error: ", error)
            return
        }

        guard let data = data else {
            print("no data in response")
            return
        }

        do {
            let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
            print("login response: ", authResponse.message)
            // TODO: actually login the user
        } catch {
            print("unable to decode response: ", error)
        }
    }.resume()
}
