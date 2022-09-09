import SwiftUI
import Firebase

@main
struct SkiDaysApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
                ContentView()
                    .environmentObject(viewModel)
        }
    }
}

