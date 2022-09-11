import SwiftUI
import Firebase

struct SettingsView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ScrollView{
            VStack{
                ThemeSettingsRow()
                SettingsRow(image: "figure.walk", title: "Sign Out")
                    .onTapGesture { viewModel.signOut() }
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
