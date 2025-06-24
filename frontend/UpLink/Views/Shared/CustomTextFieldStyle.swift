import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("BackgroundAccent"))
                    .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("ForegroundColor"), lineWidth: 0)
            )
            .font(.custom("Rubik", size: 18))
            .foregroundColor(Color("ForegroundColor"))
    }
}
