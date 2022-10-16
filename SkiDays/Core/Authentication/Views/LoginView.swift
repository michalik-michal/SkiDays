import SwiftUI

// ADD PITCURE AS HEADER BACKGROUND (?)

struct LoginView: View {

    @State private var email = ""
    @State private var password = ""
    @State private var showError = false
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        NavigationView {
            VStack {
                AuthenticationHeader(title1: "Hello.", title2: "Great to se you again")
                VStack(spacing: 40) {
                    CustomInputField(imageName: "envelope", placeholderText: "Email", text: $email)
                    SecureTextField(password: $password)
                }
                .padding(.horizontal, 32)
                .padding(.top, 42)
                HStack {
                    Spacer()
                    NavigationLink {
                        Text("Reset password view...")
                    } label: {
                        Text("Forgot Password?")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.blackWhite)
                            .padding(.top)
                            .padding(.trailing, 24)
                    }
                }
                Button {
                    viewModel.login(withEmail: email, password: password)
                } label: {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color.darkerBlue)
                        .clipShape(Capsule())
                        .padding()
                }
                Spacer()
                NavigationLink {
                    RegistrationView()
                        .navigationBarHidden(true)
                } label: {
                    HStack {
                        Text("Dont have an account?")
                            .font(.footnote)
                        Text("Sign Up")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                }
                .padding(.bottom, 32)
                .foregroundColor(.blackWhite)
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
            .background(Color.background)
            .overlay { if viewModel.shouldShowMessage { MessageView(image: "xmark", message: "Oops there was some error") } }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
