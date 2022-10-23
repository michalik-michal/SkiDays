import SwiftUI
import UIKit
import Lottie

struct ErrorView: UIViewRepresentable {
    typealias UIViewType = UIView

    func makeUIView(context: UIViewRepresentableContext<ErrorView>) -> UIView {
        let view = UIView(frame: .zero)

        let animationView = LottieAnimationView()

        animationView.animation = LottieAnimation.named("error")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        return view
    }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<ErrorView>) {}
}
