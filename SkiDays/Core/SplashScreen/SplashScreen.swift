import SwiftUI

struct SplashScreen: View {

    @State var animate = false
    @State var endSplash = false

    var body: some View {
        VStack(spacing: -45) {
            Text("SKI")
                .font(.system(size: 130).bold())
            Text("DAYS")
                .font(.system(size: 80).bold())
        }
        .scaleEffect(animate ? 1 : 0)
        .onAppear { animateSplash() }
        .foregroundColor(.blackWhite)
        .ignoresSafeArea()
        .frame(width: UIScreen.main.bounds.size.width,
               height: UIScreen.main.bounds.size.height)
        .background(Color.background)
    }

    private func animateSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            withAnimation(Animation.interactiveSpring()) {
                animate.toggle()
            }
            withAnimation(Animation.interactiveSpring()) {
                endSplash.toggle()
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
