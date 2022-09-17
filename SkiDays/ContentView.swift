import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            if viewModel.userSession == nil{
                LoginView()
            } else {
                MainTabView()
            }
            SplashScreen()
                .ignoresSafeArea()
                .hide(if: !viewModel.showSplashScreen)
        }
        .onAppear {
            withAnimation {
                viewModel.showSplashScreen = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
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
