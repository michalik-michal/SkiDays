import SwiftUI
import Firebase

struct SettingsView: View {

    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showingConfirmation = false

    var body: some View {
        ScrollView {
            VStack {
                ThemeSettingsRow()
                SettingsRow(image: "figure.walk", title: "Sign Out")
                    .onTapGesture { showingConfirmation = true }
                    .alert(isPresented: $showingConfirmation) {
                        Alert(
                            title: Text("Sign Out ?"),
                            primaryButton: .destructive(Text("Sign Out")) { viewModel.signOut() },
                            secondaryButton: .cancel())
                    }
            }
        }
        .foregroundColor(.blackWhite)
        .background(Color.background)
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
