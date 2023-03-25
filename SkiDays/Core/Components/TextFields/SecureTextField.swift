import SwiftUI

struct SecureTextField: View {

    @Binding var password: String
    @State var isSecure: Bool = true
    private var shouldHideDelete: Bool {
        if password != "" {
            return false
        } else {
            return true
        }
    }

    var body: some View {
        ZStack(alignment: .trailing) {
            if isSecure {
                CustomInputField(imageName: "lock", placeholderText: "Password", isSecureField: true, text: $password)
            } else {
                CustomInputField(imageName: "lock", placeholderText: "Password", isSecureField: false, text: $password)
            }
            Button {
                isSecure.toggle()
            } label: {
                Image(systemName: self.isSecure ? "eye.slash" : "eye")
                    .foregroundColor(Color(.darkGray))
            }
            .padding(.bottom, 3)
        }
    }
}

struct SecureTextField_Previews: PreviewProvider {
    @State static var text = "test"
    static var previews: some View {
        SecureTextField(password: .constant(""))
    }
}
