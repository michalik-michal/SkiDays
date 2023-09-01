import AVKit
import SwiftUI

struct CustomVideoPlayer: UIViewControllerRepresentable {
    var url: URL

    func makeUIViewController(context:
                              UIViewControllerRepresentableContext<CustomVideoPlayer>) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        let player1 = AVPlayer(url: url)
        controller.player = player1
        controller.modalPresentationStyle = .fullScreen
        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController,
                                context: UIViewControllerRepresentableContext<CustomVideoPlayer>) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: CustomVideoPlayer

        init(_ parent: CustomVideoPlayer) {
            self.parent = parent
        }
    }
}
