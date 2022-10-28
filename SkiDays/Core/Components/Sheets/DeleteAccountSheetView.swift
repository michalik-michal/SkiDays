import SwiftUI

struct DeleteAccountSheetView: View {

    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var viewModel = SettingsViewModel()
    @State var password = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text("Enter password to delete account")
                .font(.title2).bold()
                .padding(.bottom, 20)
            SecureTextField(password: $password)
            Spacer()
            Button {
                viewModel.service.reauthenticateUser(password: password) { result in
                    switch result {
                    case .success:
                        if let uid = viewModel.service.currentUser?.uid {
                            viewModel.service.deleteUserData(uid: uid) { result in
                                switch result {
                                case .success:
                                    viewModel.service.deleteUser { result in
                                        switch result {
                                        case .success:
                                            print("User deleted")
                                            authViewModel.currentUser = nil
                                            authViewModel.userSession = nil
                                        case .failure:
                                            print("Cant delete user")
                                        }
                                    }
                                case .failure:
                                    print("Cant delete user data")
                                }
                            }
                        } else {
                            print("CANT DELEte")
                        }
                    case .failure:
                        print("Cant reauthenticate")
                    }
                }
            } label: {
                Text("Delete ")
                    .font(.title3).bold()
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(12)
                    .foregroundColor(.blackWhite)
            }
        }
    }
}

struct DeleteAccountSheetView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAccountSheetView(password: "")
    }
}
