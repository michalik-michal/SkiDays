import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {

    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var shouldShowMessage = false
    @Published var showSplashScreen = false
    @Published var showResetPassword = false
    @Published var alertMessage = ""
    @Published var alertImage = ""

    private let service = UserService()

    init() {
        self.showSplashScreen.toggle()
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
    }
    // MARK: - Log In User
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to sign in user with error: \(error)")
                self.alertImage = "xmark"
                self.alertMessage = "Unable to Log in"
                self.shouldShowMessage = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.shouldShowMessage = false
                }
            }
            guard let user = result?.user else {return}
            self.userSession = user
            self.fetchUser()
        }
    }
    // MARK: - Register User
    func register(withEmail email: String, password: String, fullname: String, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to register the user \(error.localizedDescription)")
                self.alertMessage = "Oops something went wrong"
                self.alertImage = "xmark"
                self.shouldShowMessage = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.shouldShowMessage = false
                }
                return
            }

            guard let user = result?.user else {return}
            self.userSession = user
            self.fetchUser()
            let data = ["email": email,
                        "username": username.lowercased(),
                        "fullname": fullname,
                        "uid": user.uid]

            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { _ in
                    print("Did update user data")
                }
        }
    }

    func fetchUser() {
        guard let uid = self.userSession?.uid else {return}
        service.fetchUser(withUid: uid) { user in
            self.currentUser = user
        }
    }

    func signOut() {
        userSession = nil
        try? Auth.auth().signOut()
    }

    func forgotPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Unable to reset password \(error)")
                self.alertMessage = "Unable to reset password"
                self.alertImage = "xmark"
                self.showResetPassword = false
                self.shouldShowMessage = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.shouldShowMessage = false
                }
            } else {
                self.alertMessage = "Email sent"
                self.alertImage = "checkmark"
                self.showResetPassword = false
                self.shouldShowMessage = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.shouldShowMessage = false
                }
            }
        }
    }
}
