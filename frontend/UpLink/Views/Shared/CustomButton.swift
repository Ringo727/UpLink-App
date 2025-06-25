import SwiftUI

struct CustomButton: View {
    var title: String
    var destination: AnyView?
    var action: (() -> Void)?

    @State private var isPressed = false
    @State private var isActive = false

    var body: some View {
        ZStack {
            NavigationLink(
                destination: destination ?? AnyView(EmptyView()),
                isActive: $isActive
            ) {
                EmptyView()
            }
            .hidden()

            Text(title)
                .frame(maxWidth: .infinity)
                .font(.custom("Rubik", size: 18))
                .fontWeight(.semibold)
                .foregroundColor(Color("ForegroundColor"))
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
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if destination != nil {
                                    isActive = true
                                } else {
                                    action?()
                                }
                            }
                        }
                )
        }
    }
}
