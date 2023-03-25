import UIKit

public extension UIApplication {

    var keyUIWindow: UIWindow? {
        UIApplication.shared.connectedScenes.lazy
            .compactMap({ $0.activationState == .foregroundActive ? ($0 as? UIWindowScene) : nil })
            .first(where: { $0.keyWindow != nil })?
            .keyWindow
    }

    var presentedViewController: UIViewController? {
        UIApplication.shared.keyUIWindow?.rootViewController?.presentedViewController
    }
}
