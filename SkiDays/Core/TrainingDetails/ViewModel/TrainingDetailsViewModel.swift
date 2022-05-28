//
//  DeleteDayViewModel.swift
//  SkiDays
//
//  Created by MacOS on 03/05/2022.
//

import Foundation


class TrainingDetailsViewModel: ObservableObject{
    
   
    let service = SkiDayService()
    
    func deleteSkiDay(_ skiDay: SkiDay){
        service.deleteSkiDay(skiDay)
    }
    
}
