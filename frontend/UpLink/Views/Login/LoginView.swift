import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            Text("Login").font(.largeTitle)

            TextField("Username", text: .constant("")).textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Password", text: .constant("")).textFieldStyle(RoundedBorderTextFieldStyle())

            CustomButton(title: "Log in") {

            }
        }
        .padding()
    }
}
