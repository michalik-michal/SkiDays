import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {

    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var shouldShowMessage = false
    @Published var showSplashScreen = false
    @Published var showResetPassword = false
    @Published var alertMessage = ""
    @Published var messageType = MessageType.error

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
                self.messageType = .error
                self.alertMessage = "Unable to Log in"
                self.shouldShowMessage = true
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
                self.messageType = .error
                self.shouldShowMessage = true
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
                self.messageType = .error
                self.showResetPassword = false
                self.shouldShowMessage = true
            } else {
                self.alertMessage = "Email sent"
                self.messageType = .succes
                self.showResetPassword = false
                self.shouldShowMessage = true
            }
        }
    }
}
