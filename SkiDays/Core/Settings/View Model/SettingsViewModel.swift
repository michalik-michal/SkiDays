import Foundation

class SettingsViewModel: ObservableObject{
    
    let service = AuthViewModel()
    
    func signOut(){
        service.signOut()
    }
    
}
