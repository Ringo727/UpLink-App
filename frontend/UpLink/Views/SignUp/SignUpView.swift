import SwiftUI

struct SignUpView: View {
    
    // for background animation
    @State private var colorCycle = false
    
    // tracking user input
    @State private var inputUsername = ""
    @State private var inputEmail = ""
    @State private var inputPassword = ""
    
    @FocusState private var showPasswordRequirements: Bool
    
    @State private var showError = false
    @State private var errorMessage = ""
    
    // checks for passwords being input
    // used to update the password requirements display
    var hasValidLength: Bool {
        inputPassword.count >= 8 && inputPassword.count <= 64
    }
    var hasUppercase: Bool {
        inputPassword.range(of: "[A-Z]", options: .regularExpression) != nil
    }
    var hasLowercase: Bool {
        inputPassword.range(of: "[a-z]", options: .regularExpression) != nil
    }
    var hasNumber: Bool {
        inputPassword.range(of: "[0-9]", options: .regularExpression) != nil
    }
    var hasSpecialCharacter: Bool {
        inputPassword.range(of: "[\\p{P}\\p{S}]", options: .regularExpression) != nil
    }
    
    var isValidEmail: Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return inputEmail.range(of: emailRegex, options: .regularExpression) != nil
    }
    
    // validates all input fields and returns error string if invalid
    func validateInput() -> String? {
        if inputUsername.isEmpty || inputEmail.isEmpty || inputPassword.isEmpty {
            return "Please fill all text fields"
        }
        if !isValidEmail {
            return "Invalid Email address"
        }
        if !hasValidLength {
            return "Password must be between 8 and 64 characters"
        }
        if !hasUppercase {
            return "Password missing an uppercase letter"
        }
        if !hasLowercase {
            return "Password missing a lowercase letter"
        }
        if !hasNumber {
            return "Password missing a number"
        }
        if !hasSpecialCharacter {
            return "Password missing a special character"
        }
        return nil
    }
    
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
                        .onChange(of: inputUsername) {
                            inputUsername = inputUsername.lowercased()
                        }
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
                        .focused($showPasswordRequirements)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        if showPasswordRequirements {
                            HStack {
                                Image(systemName: hasValidLength ? "checkmark.circle" : "x.circle")
                                    .foregroundColor(hasValidLength ? Color("ButtonColor") : Color("ErrorColor"))
                                Text("Between 8 and 64 Characters")
                                    .foregroundColor(hasValidLength ? Color("ButtonColor") : Color("ErrorColor"))
                            }

                            HStack {
                                Image(systemName: hasUppercase ? "checkmark.circle" : "x.circle")
                                    .foregroundColor(hasUppercase ? Color("ButtonColor") : Color("ErrorColor"))
                                Text("1 Uppercase Letter")
                                    .foregroundColor(hasUppercase ? Color("ButtonColor") : Color("ErrorColor"))
                            }

                            HStack {
                                Image(systemName: hasLowercase ? "checkmark.circle" : "x.circle")
                                    .foregroundColor(hasLowercase ? Color("ButtonColor") : Color("ErrorColor"))
                                Text("1 Lowercase Letter")
                                    .foregroundColor(hasLowercase ? Color("ButtonColor") : Color("ErrorColor"))
                            }

                            HStack {
                                Image(systemName: hasNumber ? "checkmark.circle" : "x.circle")
                                    .foregroundColor(hasNumber ? Color("ButtonColor") : Color("ErrorColor"))
                                Text("1 Number (0-9)")
                                    .foregroundColor(hasNumber ? Color("ButtonColor") : Color("ErrorColor"))
                            }

                            HStack {
                                Image(systemName: hasSpecialCharacter ? "checkmark.circle" : "x.circle")
                                    .foregroundColor(hasSpecialCharacter ? Color("ButtonColor") : Color("ErrorColor"))
                                Text("1 Special Character")
                                    .foregroundColor(hasSpecialCharacter ? Color("ButtonColor") : Color("ErrorColor"))
                            }
                        }
                    }
                    .font(.custom("Rubik", size: 16))
                    .fontWeight(.regular)
                    .foregroundColor(Color("ForegroundColor").opacity(0.7))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .opacity(showPasswordRequirements ? 1 : 0)
                    .frame(height: showPasswordRequirements ? nil : 0)
                    .padding(.leading, 34)
                    
                    CustomButton(title: "SIGN UP", destination: nil, action: {
                        if let validationError = validateInput() {
                            errorMessage = validationError

                            withAnimation {
                                showError = true
                            }

                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation {
                                    showError = false
                                }
                            }
                        }
                        else {
                            print("Button tapped") // change this to make a call to the backend database to add a user
                        }
                    }).padding(.top, 8)
                    
                    ZStack {
                        ErrorDisplay(errorMessage: errorMessage)
                            .offset(y: showError ? 0 : -5)
                            .opacity(showError ? 1 : 0)
                            .animation(.spring(response: 0.4, dampingFraction: 0.7), value: showError)
                    }
                    .frame(height: 75)
                    .padding(.bottom, 30)
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
