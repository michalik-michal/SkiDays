//
//  StatsService.swift
//  SkiDays
//
//  Created by MacOS on 07/06/2022.
//

import Foundation
import Firebase

struct StatsService{
    
    func fetchSkiDaysForUid(forUid uid: String, completion: @escaping([SkiDay]) -> Void){
        
        Firestore.firestore().collection("skidays")
            
            .whereField("uid", isEqualTo: uid)
            .addSnapshotListener { snapshot, _ in
            guard let documents = snapshot?.documents else {return}

            let skiDays = documents.compactMap({try? $0.data(as: SkiDay.self)})
            completion(skiDays.sorted(by: {$0.date > $1.date}))
        }
    }
}
