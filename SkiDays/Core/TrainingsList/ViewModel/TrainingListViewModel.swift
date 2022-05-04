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
    
    let service = SkiDayService()
    
    init(){
        fetchSkidays()
        
//        let db = Firestore.firestore()
//        db.collection("skidays").addSnapshotListener{(snap, error) in
//            if error != nil {
//                print("error")
//                return
//            }
//            for i in snap!.documentChanges{
//                if i.type == .added{
//                    self.fetchSkidays()
//                }
//            }
//        }
    }
    
    func fetchSkidays(){
        service.fetchSkiDays { skiDays in
            self.skiDays = skiDays
        }
    }
}
