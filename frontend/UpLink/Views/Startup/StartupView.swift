import SwiftUI

struct StartupView: View {
    
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

            VStack(spacing: 30) {
                
                Spacer()
                
                HStack(spacing: 10) {
                    Image(systemName: "bubble.left.and.bubble.right.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color("ButtonColor"))

                    Text("UpLink")
                        .font(.custom("Rubik", size: 60))
                        .foregroundColor(Color("ForegroundColor"))
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color("BackgroundAccent"), lineWidth: 4)
                )


                Spacer()
                
                CustomButton(title: "Sign Up") {
                    
                }.frame(width: 300)
                
                CustomButton(title: "Log In") {
                    
                }.frame(width: 300)
                    .padding(.bottom, 60)
                
            }
            .padding()
        }
    }
}

#Preview {
    StartupView()
}
