import SwiftUI

struct SettingsRow: View {

    var image: String
    var title: String

    var body: some View {
        VStack {
            HStack {
                Image(systemName: image)
                Text(title)
                Spacer()
            }
            .frame(height: 50)
            .padding(.horizontal)
            Divider()
        }

    }
}

struct SettingsRow_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRow(image: "figure.walk", title: "Sign out")
    }
}
