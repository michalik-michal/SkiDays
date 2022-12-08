import SwiftUI

struct SplashScreen: View {

    @State private var opacity = 0.0

    var body: some View {
        ZStack {
            Color.background
            Image("AppLogo")
                .resizable()
                .frame(width: 200, height: 200)
                .opacity(opacity)
                .onAppear {
                    withAnimation {
                        opacity = 1.0
                    }
                }
                .ignoresSafeArea()
        }
        .frame(width: UIScreen.main.bounds.width,
               height: UIScreen.main.bounds.height)
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
