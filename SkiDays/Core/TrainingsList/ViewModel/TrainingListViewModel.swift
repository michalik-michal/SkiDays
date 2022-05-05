//
//  TrainingListViewModel.swift
//  SkiDays
//
//  Created by MacOS on 02/05/2022.
//

import Foundation
import FirebaseFirestore

class TrainingListViewModel: ObservableObject{
    
    @Published var skiDays = [SkiDay]()
    
    private let service = SkiDayService()
    let user: User
    
    init(user: User){
        self.user = user
        self.fetchUserSkidays()
    }

    
    func fetchUserSkidays(){
        guard let uid = user.id else {return}
        service.fetchSkiDaysForUid(forUid: uid) { skiDays in
            self.skiDays = skiDays
        }
    }
}
