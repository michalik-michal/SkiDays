import SwiftUI

struct MainTabView: View {
    
    @State private var selectedIndex = 1
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser{
            TabView(selection: $selectedIndex){
                TrainingsListView(user: user)
                    .onAppear {
                        self.selectedIndex = 0
                    }
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("SkiDays")
                    }.tag(0)
                HomeView(user: user)
                    .onAppear {
                        self.selectedIndex = 1
                    }
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }.tag(1)
                StatsView(user: user)
                    .onAppear {
                        self.selectedIndex = 2
                    }
                    .tabItem {
                        Image(systemName: "chart.bar.xaxis")
                        Text("Stats")
                    }.tag(2)
            }
            .foregroundColor(.blackWhite)
            .background(Color.secondayBackground)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
