import SwiftUI

struct LoginView: View {
    
    // for background animation
    @State private var colorCycle = false
    
    // tracking user input
    @State private var inputEmail = ""
    @State private var inputPassword = ""
    
    var body: some View {
        ZStack {
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
                        Image(systemName: "person.badge.key.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(Color("ButtonColor"), Color("ForegroundColor"))
                        Text("Log In")
                            .font(.custom("Rubik", size: 40))
                            .fontWeight(.bold)
                            .foregroundStyle(Color("ForegroundColor"))
                    }
                    VStack(spacing: 10) {
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

                        CustomButton(title: "LOG IN", destination: nil, action: {
                            loginUser(email: inputEmail, password: inputPassword)
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
}

#Preview {
    LoginView()
}
