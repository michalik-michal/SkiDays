import SwiftUI
import Firebase

struct SettingsView: View {

    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var viewModel = SettingsViewModel()

    @State private var feedback = ""
    @State private var password = ""

    var body: some View {
        ScrollView {
            VStack {
                ThemeSettingsRow()
                SettingsRow(image: "heart", title: "Give Feedback")
                    .onTapGesture { viewModel.showFeedbackSheet = true }
                    .sheet(isPresented: $viewModel.showFeedbackSheet) {
                        VStack(alignment: .leading) {
                            Text("Got some idea? Share it with us!")
                                .font(.title2).bold()
                            TextEditor(text: $feedback)
                                .background(Color.background)
                                .scrollContentBackground(.hidden)
                                .cornerRadius(12)
                             Spacer()
                            Button {
                                viewModel.submitFeedback(feedback)
                            } label: {
                                Text("Submmit")
                                    .font(.title3).bold()
                                    .frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.background)
                                    .cornerRadius(12)
                            }
                        }
                        .padding()
                        .presentationDetents([.medium])
                    }
                SettingsRow(image: "trash", title: "Delete Account")
                    .onTapGesture { viewModel.showDeleteAccount = true }
                    .sheet(isPresented: $viewModel.showDeleteAccount) {
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
                            }
                        }
                        .padding()
                        .presentationDetents([.height(300)])
                    }

                SettingsRow(image: "figure.walk", title: "Sign Out")
                    .onTapGesture { viewModel.showingConfirmation = true }
                    .alert(isPresented: $viewModel.showingConfirmation) {
                        Alert(
                            title: Text("Sign Out ?"),
                            primaryButton: .destructive(Text("Sign Out")) { authViewModel.signOut() },
                            secondaryButton: .cancel())
                    }
            }
        }
        .foregroundColor(.blackWhite)
        .background(Color.background)
        .navigationTitle("Settings")
        .overlay {
            MessageView(messageType: .succes,
                        message: "Thank you for giving feedback!",
                        isVisible: $viewModel.shouldMessageView)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
