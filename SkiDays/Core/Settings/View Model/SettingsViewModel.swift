import Foundation
import UIKit

class SettingsViewModel: ObservableObject{
    
    let service = AuthViewModel()
    var mode = UIUserInterfaceStyle.unspecified
    
    func signOut() {
        service.signOut()
    }
    
    func setAppTheme(tag: Int) {
        switch tag {
        case 0:
            mode = UIUserInterfaceStyle.light
            UserDefaults.standard.set("light", forKey: "appTheme")
        case 1:
            mode = UIUserInterfaceStyle.dark
            UserDefaults.standard.set("dark", forKey: "appTheme")
        default:
            mode = UIUserInterfaceStyle.unspecified
            UserDefaults.standard.set("system", forKey: "appTheme")
        }
      (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = mode
    }
    
    func getAppTheme() {
        let theme = UserDefaults.standard.string(forKey: "appTheme")
        switch theme {
        case "light":
            mode = UIUserInterfaceStyle.light
        case "dark":
            mode = UIUserInterfaceStyle.dark
        default:
            mode = UIUserInterfaceStyle.unspecified
        }
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = mode
    }
    
    func getSelectedMode() -> Int {
        let theme = UserDefaults.standard.string(forKey: "appTheme")
        switch theme {
        case "light":
            return 0
        case "dark":
            return 1
        default:
            return 2
        }
    }
    
}
