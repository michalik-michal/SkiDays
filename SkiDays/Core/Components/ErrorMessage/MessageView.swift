import SwiftUI

enum MessageType {
    case succes
    case error
}

struct MessageView: View {

    @Binding var isVisible: Bool
    var messageType: MessageType
    var message: String
    var time: Double {
        if messageType == .succes {
            return 1.2
        } else {
            return 1.8
        }
    }

    var body: some View {
        VStack(spacing: 40) {
            switch messageType {
            case .succes:
                CheckmarkView()
                    .frame(width: 150, height: 150)
                    .scaleEffect(2)
            case .error:
                Image(systemName: "exclamationmark.bubble")
                    .resizable()
                    .foregroundColor(.gray)
                    .frame(width: 100, height: 100)
            }
            if message != "" {
                Text(message)
                    .font(.title3.bold())
                    .foregroundColor(.gray.opacity(0.5))
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(width: 280, height: 280)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.background, lineWidth: 4)
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                isVisible = false
            }
        }
        .hide(if: !isVisible)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(isVisible: .constant(true), messageType: .succes, message: "Oops, there was some error")
    }
}
