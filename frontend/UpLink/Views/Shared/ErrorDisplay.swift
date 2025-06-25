import SwiftUI

struct ErrorDisplay : View {
    
    var errorMessage: String?
    
    var body : some View {
        HStack {
            Image(systemName: "exclamationmark.circle")
                .foregroundStyle(Color("ForegroundColor"))
                .fontWeight(.bold)
            
            Text(errorMessage ?? "ERROR")
                .foregroundStyle(Color("ForegroundColor"))
                .font(.custom("Rubik", size: 16))
                .fontWeight(.bold)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 10)
        .background(Color("ErrorColor").opacity(0.75))
        .cornerRadius(10)
        .fixedSize(horizontal: false, vertical: true)
    }
}


#Preview {
    ZStack {
        Color("BackgroundColor").ignoresSafeArea()
        VStack {
            ErrorDisplay(errorMessage: "Something went wrong...")
            ErrorDisplay()
        }
    }
}
