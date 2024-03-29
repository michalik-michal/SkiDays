import SwiftUI

struct RegistrationView: View {

    @State private var email = ""
    @State private var username = ""
    @State private var fullname = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            AuthenticationHeader(title1: "Create your account.", title2: "")
            VStack(spacing: 40) {
                CustomInputField(imageName: "envelope", placeholderText: "Email", text: $email)
                    .autocapitalization(.none)
                CustomInputField(imageName: "person", placeholderText: "username", text: $username)
                    .autocapitalization(.none)
                CustomInputField(imageName: "person", placeholderText: "Full Name", text: $fullname)
                SecureTextField(password: $password)
            }
            .padding(32)
            Button {
                viewModel.register(withEmail: email, password: password, fullname: fullname, username: username)
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                    .padding()
            }
            Spacer()
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Text("Already have an account?")
                        .font(.footnote)
                    Text("Sign In")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 32)
        }
        .ignoresSafeArea()
        .foregroundColor(.blackWhite)
        .background(Color.background)
        .overlay {
            MessageView(isVisible: $viewModel.shouldShowMessage,
                        messageType: .error,
                        message: "Oops there was some error")
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
