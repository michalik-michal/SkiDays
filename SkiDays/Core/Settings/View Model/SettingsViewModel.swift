//
//  SettingsViewModel.swift
//  SkiDays
//
//  Created by MacOS on 04/05/2022.
//

import Foundation


class SettingsViewModel: ObservableObject{
    
    let service = AuthViewModel()
    
    
    func signOut(){
        service.signOut()
    }
    
}
