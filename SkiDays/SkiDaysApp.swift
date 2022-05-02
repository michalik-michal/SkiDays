//
//  SkiDaysApp.swift
//  SkiDays
//
//  Created by MacOS on 29/04/2022.
//

import SwiftUI
import Firebase

@main
struct SkiDaysApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }
            .environmentObject(viewModel)
        }
    }
}
 
