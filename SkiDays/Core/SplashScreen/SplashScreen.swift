import SwiftUI

struct SplashScreen: View {

    @State var animate = false
    @State var endSplash = false

    var body: some View {
//        VStack(spacing: -45) {
//            Text("SKI")
//                .font(.system(size: 130).bold())
        //            Text("DAYS")
        //                .font(.system(size: 80).bold())
        //        }
        ZStack {
            Color.background
            Image("AppLogo")
                .resizable()
                .frame(width: 200, height: 200)
                .scaleEffect(animate ? 1 : 0)
                .onAppear { animateSplash() }
                .ignoresSafeArea()
        }
        .frame(width: UIScreen.main.bounds.width,
               height: UIScreen.main.bounds.height)
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
