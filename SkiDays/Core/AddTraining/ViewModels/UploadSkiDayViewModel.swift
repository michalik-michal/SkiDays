//
//  UploadSkiDayViewModel.swift
//  SkiDays
//
//  Created by MacOS on 02/05/2022.
//

import Foundation
import SwiftUI

class UploadSkiDayViewModel: ObservableObject{
    
    @Published var didUploadSkiDay = false
    let service = SkiDayService()
    
    func uploadSkiDay(date: String, discipline: String, place: String,conditions: String, runs: Int, gates: Int, notes: String){
        service.uploadSkiDay(date: date,
                             discipline: discipline,
                             place: place,
                             conditions: conditions,
                             runs: runs,
                             gates: gates,
                             notes: notes) { succes in
            
            if succes{
                self.didUploadSkiDay = true
            }else{
                //show error message
            }
        }
    }
    func provideTitle(_ discipline: String) -> String{
        
        if discipline == ""{
            return "Add New Training"
        }
        if discipline == "FREE"{
            return "FREE SKIING"
        }
        if discipline == "PARA"{
            return "PARALLEL"
        }else{
            return discipline
        }
    }
}
