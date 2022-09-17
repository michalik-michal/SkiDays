import SwiftUI

struct SecureTextField: View {
    
    @Binding var password: String
    @State var isSecure: Bool = true
    private var shouldHideDelete: Bool {
        if password == "" {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        ZStack(alignment: .trailing){
            if isSecure{
                CustomInputField(imageName: "lock", placeholderText: "Password", isSecureField: true, text: $password)
            }else{
                CustomInputField(imageName: "lock", placeholderText: "Password", isSecureField: false, text: $password)
            }
            HStack {
                Button {
                    password = ""
                } label: {
                    Image(systemName: "x.circle")
                        .foregroundColor(Color(.darkGray))
                }.hide(if: shouldHideDelete)
                Button {
                    isSecure.toggle()
                } label: {
                    Image(systemName: self.isSecure ? "eye.slash" : "eye")
                        .foregroundColor(Color(.darkGray))
                }
            }
        }
    }
}

struct SecureTextField_Previews: PreviewProvider {
    
    @State static var text = "test"
    static var previews: some View {
        SecureTextField(password: .constant(""))
    }
}
