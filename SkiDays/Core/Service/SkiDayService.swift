//
//  TrainingService.swift
//  SkiDays
//
//  Created by MacOS on 02/05/2022.
//

import Firebase

struct SkiDayService{
     
    func uploadSkiDay(date: String, discipline: String, place: String,conditions:String, runs: Int, gates: Int, notes: String, completion: @escaping(Bool) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let data = ["uid": uid,
                    "date": date ,
                    "discipline": discipline,
                    "conditions": conditions,
                    "place": place,
                    "runs": runs,
                    "gates": gates,
                    "notes": notes
        ]as [String : Any]
        
        Firestore.firestore().collection("skidays").document()
            .setData(data) { error in
                if let error = error{
                    print("Failed to upload SkiDay wiht errror: \(error)")
                    completion(false)
                    return
                }
                completion(true)
            }
    }
    func fetchSkiDays(completion: @escaping([SkiDay]) -> Void){
        
        Firestore.firestore().collection("skidays").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else {return}

            let skiDays = documents.compactMap({try? $0.data(as: SkiDay.self)})
            completion(skiDays)
            
        }
    }
//    func deleteSkiDay(_ skiDay: SkiDay){
//        print("\(Firestore.firestore().collection("skidays").document(skiDay.id!))")
//    }
}
