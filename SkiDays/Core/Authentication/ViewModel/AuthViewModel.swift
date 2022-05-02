//
//  AuthViewModel.swift
//  SkiDays
//
//  Created by MacOS on 02/05/2022.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject{
    
    @Published var userSession: FirebaseAuth.User?
    
    init(){
        self.userSession = Auth.auth().currentUser
    }
    
//MARK: - Log In User
    
    func login(withEmail email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error{
                print("Failed to sign in user with error: \(error)")
            }
            guard let user = result?.user else {return}
            self.userSession = user
        }
    }
    
//MARK: - Register User
    
    func register(withEmail email: String, password: String, fullname: String, username: String){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error{
                print("Failed to register the user \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else {return}
            self.userSession = user
            
            let data = ["email" : email,
                        "username" : username.lowercased(),
                        "fullname" : fullname,
                        "uid" : user.uid]
            
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { _ in
                    print("Did update user data")
                }
        }
    }

//MARK: - Log Out User
    
    func signOut(){
        
        //Show login view
        userSession = nil
        
        // Signs out on server
        try? Auth.auth().signOut()
    }
}
