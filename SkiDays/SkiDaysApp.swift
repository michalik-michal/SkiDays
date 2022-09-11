import SwiftUI
import Firebase

@main
struct SkiDaysApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    @StateObject var settings = SettingsViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
                ContentView()
                    .environmentObject(viewModel)
                    .onAppear { settings.getAppTheme() }
        }
    }
}

