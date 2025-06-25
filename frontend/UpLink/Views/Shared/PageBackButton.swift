import SwiftUI

struct PageBackButton : View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body : some View {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundStyle(Color("ForegroundColor"))
                    .fontWeight(.bold)
            }
    }
}

#Preview {
    ZStack {
        Color("BackgroundColor").ignoresSafeArea()
        PageBackButton()
    }
}
