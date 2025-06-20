import SwiftUI

struct StartupView: View {
    var body: some View {
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)
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
