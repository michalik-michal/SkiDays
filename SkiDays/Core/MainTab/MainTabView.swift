//
//  MainTabView.swift
//  SkiDays
//
//  Created by MacOS on 29/04/2022.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selectedIndex = 1
    @EnvironmentObject var viewModel: AuthViewModel
   
   
    var body: some View {
        if let user = viewModel.currentUser{
            TabView(selection: $selectedIndex){
                
                TrainingsListView(user: user)
                    .onTapGesture {
                        self.selectedIndex = 0
                    }
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("SkiDays")
                    }.tag(0)
                
                HomeView(user: user)
                    .onTapGesture {
                        self.selectedIndex = 1
                    }
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }.tag(1)
                
                StatsView(user: user)
                    .onTapGesture {
                        self.selectedIndex = 2
                    }
                    .tabItem {
                        Image(systemName: "waveform.path.ecg")
                        Text("Stats")
                    }.tag(2)
            }
            .foregroundColor(.black)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
