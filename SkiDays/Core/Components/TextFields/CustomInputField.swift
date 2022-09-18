import SwiftUI

struct CustomInputField: View {
    
    let imageName: String
    let placeholderText: String
    var isSecureField: Bool? = false
    private var shouldHideDelete: Bool {
        if text == "" {
            return true
        } else {
            return false
        }
    }
    
    @Binding var text: String
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                if isSecureField ?? false{
                    SecureField(placeholderText, text: $text)
                }else{
                    TextField(placeholderText, text: $text)
                }
                Button {
                    text = ""
                } label: {
                    Image(systemName: "x.circle")
                        .foregroundColor(Color(.darkGray))
                }.hide(if: shouldHideDelete)
                
            }
            Divider()
                .background(Color(.darkGray))
        }
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(imageName: "envelope", placeholderText: "Email", isSecureField: false, text: .constant(""))
    }
}
