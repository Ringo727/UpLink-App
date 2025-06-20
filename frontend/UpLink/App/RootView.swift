// RootView for UpLink

// handles routing for the frontend

import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome!").font(.custom("Rubik", size: 24))
                NavigationLink("Go to Login", destination: LoginView())
            }
        }
    }
}

#Preview {
    RootView()
}
