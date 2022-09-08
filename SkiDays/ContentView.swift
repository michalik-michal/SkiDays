import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if viewModel.userSession == nil{
            LoginView()
        } else {
            MainTabView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
