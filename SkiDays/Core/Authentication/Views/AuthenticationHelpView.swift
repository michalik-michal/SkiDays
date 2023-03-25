import SwiftUI

struct AuthenticationHelpView: View {

    @StateObject var settingsViewModel = SettingsViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var viewModel = AuthenticationHelpViewModel()

    let feedbackService = FeedbackService()

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            VStack {
                CustomInputField(imageName: "envelope", placeholderText: "Enter email", text: $viewModel.email)
                    .padding(.top)
                TextEditor(text: $viewModel.message)
                    .background(Color.secondayBackground)
                    .scrollContentBackground(.hidden)
                    .cornerRadius(12)
                    .frame(height: 250)
                sendFeedbackButton
                Spacer()
                resetAccountButton
            }
            .background(Color.background)
            .onTapGesture {
                self.endTextEditing()
            }
            .navigationTitle("Need help? Write to us.")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
            .overlay {
                MessageView(isVisible: $viewModel.showConfirmation,
                            messageType: .succes,
                            message: "Message sent.")
            }
            .sheet(isPresented: $viewModel.showResetAccount) {
                VStack(alignment: .leading) {
                    Text("Enter password to delete account")
                        .font(.title2).bold()
                        .padding(.bottom, 20)
                    CustomInputField(imageName: "envelope",
                                     placeholderText: "Email",
                                     text: $viewModel.emailForAccoundReset)
                    .padding(.bottom, 30)
                    SecureTextField(password: $viewModel.password)
                    Spacer()
                    Button {
                        authViewModel.reauthenticateUserWithEmail(email: viewModel.emailForAccoundReset,
                                                                  password: viewModel.password) { result in
                            switch result {
                            case .success:
                                authViewModel.deleteUser { result in
                                    switch result {
                                    case .success:
                                        print("User deleted")
                                        authViewModel.currentUser = nil
                                        authViewModel.userSession = nil
                                        viewModel.showResetAccount = false
                                    case .failure:
                                        print("Cant delete user")
                                    }
                                }
                            case .failure:
                                print("Cant reauthenticate")
                            }
                        }
                    } label: {
                        Text("Delete")
                            .font(.title3).bold()
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(12)
                            .foregroundColor(.blackWhite)
                    }
                }
                .padding()
                .presentationDetents([.height(350)])
            }
        }
    }

    private var sendFeedbackButton: some View {
        Button {
            feedbackService.uploadMessage(email: viewModel.email, viewModel.message) { succes in
                if succes {
                    viewModel.showConfirmation = true
                } else {
                    print("Cant upload feedback")
                }
            }
            self.endTextEditing()
        } label: {
            Text("Send")
                .font(.title3).bold()
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(Color.secondayBackground)
                .cornerRadius(12)
        }
    }

    private var resetAccountButton: some View {
        Button {
            viewModel.showResetAccount = true
        } label: {
                Text("Reset account?")
                .foregroundColor(.red)
        }
    }
}

struct AuthenticationHelpView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationHelpView()
    }
}
