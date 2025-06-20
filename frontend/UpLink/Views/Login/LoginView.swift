import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)
            VStack {
                Text("Log In")
                    .font(.custom("Rubik", size: 32))
                    .foregroundStyle(Color("ForegroundColor"))
                
                TextField("Username", text: .constant("")).textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Password", text: .constant("")).textFieldStyle(RoundedBorderTextFieldStyle())
                
                CustomButton(title: "Log In") {
                    
                }
            }
            .padding()
        }
    }
}

#Preview {
    LoginView()
}
