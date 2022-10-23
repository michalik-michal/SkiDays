import SwiftUI

enum MessageType {
    case succes
    case error
}

struct MessageView: View {

    var messageType: MessageType
    var message: String
    @Binding var isVisible: Bool

    var body: some View {
        VStack(spacing: 40) {
            switch messageType {
            case .succes:
                CheckmarkView()
                    .frame(width: 150, height: 150)
                    .scaleEffect(2)
            case .error:
                ErrorView()
                    .frame(width: 100, height: 100)
            }
            Text(message)
                .font(.title3.bold())
                .foregroundColor(.gray.opacity(0.5))
                .padding(.horizontal)
                .multilineTextAlignment(.center)
                .hide(if: message == "")
        }
        .frame(width: 280, height: 280)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.background, lineWidth: 4)
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                isVisible = false
            }
        }
        .hide(if: !isVisible)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(messageType: .succes, message: "Oops, there was some error", isVisible: .constant(true))
    }
}
