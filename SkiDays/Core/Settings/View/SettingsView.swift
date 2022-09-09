import SwiftUI
import Firebase

struct SettingsView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ScrollView{
            VStack{
                signoutButton
            }
        }
        .foregroundColor(.blackWhite)
        .padding()
        .background(Color.background)
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView {
    
    var signoutButton: some View{
        Button {
            viewModel.signOut()
        } label: {
            Text("Sign Out")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .clipShape(Capsule())
        }
        .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
    }
}
