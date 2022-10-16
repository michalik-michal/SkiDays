import SwiftUI

struct MessageView: View {

    var image: String
    var message: String

    var body: some View {
        VStack(spacing: 40) {
            Image(systemName: image)
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray.opacity(0.5))
            Text(message)
                .font(.title3.bold())
                .foregroundColor(.gray.opacity(0.5))
                .padding(.horizontal)
                .multilineTextAlignment(.center)
        }
        .frame(width: 280, height: 300)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.background, lineWidth: 4)
            )
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(image: "xmark", message: "Oops, there was some error")
    }
}
