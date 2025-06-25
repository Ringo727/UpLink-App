import SwiftUI

struct ErrorDisplay : View {
    
    var body : some View {
            Text("ERROR")
            .background(Color("ErrorColor"))
            .foregroundStyle(Color("ForegroundColor"))
    }
}


#Preview {
    ZStack {
        Color("BackgroundColor").ignoresSafeArea()
        ErrorDisplay()
    }
}
