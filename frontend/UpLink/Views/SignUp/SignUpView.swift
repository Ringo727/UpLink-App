import SwiftUI

struct SignUpView: View {
    
    @State private var colorCycle = false
    
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
                        .foregroundColor(Color("ButtonColor"))
                    Text("Sign Up")
                        .font(.custom("Rubik", size: 40))
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
                            text: .constant(""),
                            prompt: Text("Username")
                                .foregroundStyle(Color("ForegroundColor").opacity(0.6))
                        )
                        .textFieldStyle(CustomTextFieldStyle())
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
                            text: .constant(""),
                            prompt: Text("Email")
                                .foregroundStyle(Color("ForegroundColor").opacity(0.6))
                        )
                        .textFieldStyle(CustomTextFieldStyle())
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
                            text: .constant(""),
                            prompt: Text("Password")
                                .foregroundStyle(Color("ForegroundColor").opacity(0.6))
                        )
                        .textFieldStyle(CustomTextFieldStyle())
                    }

                    CustomButton(title: "Sign Up", destination: nil, action: {
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
