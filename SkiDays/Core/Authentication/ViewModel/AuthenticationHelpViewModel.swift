import Foundation
import SwiftUI

class AuthenticationHelpViewModel: ObservableObject {

    @Published var message = ""
    @Published var email = ""
    @Published var showConfirmation = false
    @Published var showResetAccount = false
    @Published var password = ""
    @Published var emailForAccoundReset = ""
}
