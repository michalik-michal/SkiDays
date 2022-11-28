import SwiftUI

struct ContentView: View {

    @EnvironmentObject var viewModel: AuthViewModel
    @ObservedObject var networkService = NetworkService()

    var body: some View {
        ZStack {
            if networkService.isConnected {
                if viewModel.userSession == nil {
                    LoginView()
                } else {
                    MainTabView()
                }
            } else {
                NoConnectionView()
            }
            SplashScreen()
                .ignoresSafeArea()
                .hide(if: !viewModel.showSplashScreen)
        }
        .onAppear {
            withAnimation {
                viewModel.showSplashScreen = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    viewModel.showSplashScreen = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
