import SwiftUI

struct AuthenticationHeader: View {

    let title1: String
    let title2: String

    var body: some View {
        VStack(alignment: .leading) {
            // Investigate
            HStack { Spacer() }
            Text(title1)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(title2)
                .font(.largeTitle)
                .fontWeight(.semibold)
        }
        .frame(height: 220)
        .padding(.leading)
        .background(Color.background)
        .foregroundColor(.blackWhite)
        .clipShape(RoundedShape(corners: [.bottomRight]))
    }
}

struct AuthenticationHeader_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationHeader(title1: "Hello.", title2: "Welcome back")
    }
}
