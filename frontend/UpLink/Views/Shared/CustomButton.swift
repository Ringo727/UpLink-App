import SwiftUI

struct CustomButton: View {
    var title: String
    var action: () -> Void

    @State private var isPressed = false

    var body: some View {
        Text(title)
            .font(.custom("Rubik", size: 24))
            .foregroundColor(.white)
            .shadow(color: Color("ButtonShadow").opacity(0.5), radius: 2, x: 0, y: 1)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(Color("ButtonColor"))
            .cornerRadius(10)
            .offset(y: isPressed ? 4 : 0)
            .animation(.easeInOut(duration: 0.2), value: isPressed)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("ButtonShadow"))
                    .offset(y: 4)
            )
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        withAnimation(.easeIn(duration: 0.1)) {
                            isPressed = true
                        }
                    }
                    .onEnded { _ in
                        withAnimation(.easeOut(duration: 0.1)) {
                            isPressed = false
                        }
                        action()
                    }
            )
    }
}
