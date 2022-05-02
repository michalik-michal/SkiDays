//
//  TrainingListViewModel.swift
//  SkiDays
//
//  Created by MacOS on 02/05/2022.
//

import Foundation


class TrainingListViewModel: ObservableObject{
    
    @Published var skiDays = [SkiDay]()
    
    let service = SkiDayService()
    
    init(){
        fetchSkidays()
    }
    
    func fetchSkidays(){
        service.fetchSkiDays { skiDays in
            self.skiDays = skiDays
        }
    }
}
