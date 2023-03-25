import UIKit

public extension UIDevice {

    static var hasNotch: Bool {
        guard let window = UIApplication.shared.keyUIWindow else { return false }
        return window.safeAreaInsets.top >= 44
    }

    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
}
