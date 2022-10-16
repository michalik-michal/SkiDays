import SwiftUI
import Firebase

struct SettingsView: View {

    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var viewModel = SettingsViewModel()

    @State private var feedback = ""

    var body: some View {
        ScrollView {
            VStack {
                ThemeSettingsRow()
                SettingsRow(image: "heart", title: "Give Feedback")
                    .onTapGesture { viewModel.showFeedbackSheet = true }
                    .sheet(isPresented: $viewModel.showFeedbackSheet) {
                        VStack(alignment: .leading) {
                            Text("Tell us what can we improve.")
                                .font(.title2).bold()
                            TextField("Type here: " ,text: $feedback , axis: .vertical)
                                .background(Color.background)
                                .textFieldStyle(.roundedBorder)
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
        .overlay { if viewModel.shouldMessageView { MessageView(image: "checkmark", message: "Thank you for giving feedback!") } }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
