import UIKit
import SwiftUI

extension Color {
    static let darkerBlue = Color("darkerBlue")
    static let lightBlue = Color("lightBlue")
    static let buttonColor = Color("buttonColor")
    static let background = Color("background")
    static let secondayBackground = Color("secondaryBackground")
    static let blackWhite = Color("blackWhite")
    static let pastelRed = Color("pastelRed")
    static let pastelBlue = Color("pastelBlue")
    static let pastelYellow = Color("pastelYellow")
    static let pastelGreen = Color("pastelGreen")
    static let pastelPurple = Color("pastelPurple")
    static let pastelOrange = Color("pastelOrange")
}

extension View {
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }

    @ViewBuilder func hide(if shouldHide: Bool) -> some View {
        if shouldHide {
            self.hidden()
        } else {
            self
        }
    }
}

public extension UIDevice {

    static var hasNotch: Bool {
        guard let window = UIApplication.shared.keyUIWindow else { return false }
        return window.safeAreaInsets.top >= 44
    }

    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
}

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
