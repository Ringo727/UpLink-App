import SwiftUI

struct SignUpView: View {
    
    // for background animation
    @State private var colorCycle = false
    
    // tracking user input
    @State private var inputUsername = ""
    @State private var inputEmail = ""
    @State private var inputPassword = ""
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    colorCycle ? Color("BackgroundColor") : Color("BackgroundAccent"),
                    colorCycle ? Color("BackgroundAccent") : Color("BackgroundColor")
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .animation(.easeInOut(duration: 10).repeatForever(autoreverses: true), value: colorCycle)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                colorCycle = true
            }

            VStack(spacing: 40) {
                HStack(spacing: 10) {
                    Image(systemName: "person.fill.badge.plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(Color("ButtonColor"), Color("ForegroundColor"))
                    Text("Sign Up")
                        .font(.custom("Rubik", size: 40))
                        .fontWeight(.bold)
                        .foregroundStyle(Color("ForegroundColor"))
                }
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color("ForegroundColor"))
                            .padding(.leading, 4)

                        TextField(
                            "Username",
                            text: $inputUsername,
                            prompt: Text("Username")
                                .foregroundStyle(Color("ForegroundColor").opacity(0.6))
                        )
                        .textFieldStyle(CustomTextFieldStyle())
                        .textInputAutocapitalization(.never)
                    }

                    HStack(spacing: 10) {
                        Image(systemName: "envelope.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color("ForegroundColor"))
                            .padding(.leading, 4)

                        TextField(
                            "Email",
                            text: $inputEmail,
                            prompt: Text("Email")
                                .foregroundStyle(Color("ForegroundColor").opacity(0.6))
                        )
                        .textFieldStyle(CustomTextFieldStyle())
                        .textInputAutocapitalization(.never)
                    }

                    HStack(spacing: 10) {
                        Image(systemName: "lock.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color("ForegroundColor"))
                            .padding(.leading, 4)

                        SecureField(
                            "Password",
                            text: $inputPassword,
                            prompt: Text("Password")
                                .foregroundStyle(Color("ForegroundColor").opacity(0.6))
                        )
                        .textFieldStyle(CustomTextFieldStyle())
                        .textInputAutocapitalization(.never)
                    }

                    CustomButton(title: "SIGN UP", destination: nil, action: {
                        print("Button tapped") // change this to make a call to the backend database to add a user
                    }).padding(.top, 8)
                }
                .padding(16)
                .cornerRadius(10)
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    PageBackButton()
                }
            }
        }
    }
}

#Preview {
    SignUpView()
}
