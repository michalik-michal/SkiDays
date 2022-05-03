//
//  HomeViewModel.swift
//  SkiDays
//
//  Created by MacOS on 03/05/2022.
//

import Foundation

class HomeViewModel: ObservableObject{
    
    @Published var skiDays = [SkiDay]()
    @Published var disciplineFilter = ""
    
    let service = SkiDayService()
    
    
    func numberOfDisciplineDays( _ discipline: String) -> Int{
        let filteredSkiDays = skiDays.filter({
            $0.discipline.contains(discipline)
        })
        return filteredSkiDays.count
    }
    
    
    
    init(){
        fetchSkiDays()
    }
    
    func fetchSkiDays(){
        service.fetchSkiDays { skiDays in
            self.skiDays = skiDays
            
        }
    }
}
