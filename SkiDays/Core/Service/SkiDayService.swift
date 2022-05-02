//
//  TrainingService.swift
//  SkiDays
//
//  Created by MacOS on 02/05/2022.
//

import Firebase

struct SkiDayService{
     
    func uploadSkiDay(date: Date, discipline: String, place: String, runs: Int, gates: Int, notes: String, completion: @escaping(Bool) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let data = ["uid": uid,
                    "date": date ,
                    "discipline": discipline,
                    "place": place,
                    "runs": runs,
                    "gates": gates,
                    "notes": notes
        ]as [String : Any]
        
        Firestore.firestore().collection("skidays").document()
            .setData(data) { error in
                if let error = error{
                    print("Failed to upload thweet wiht erorror: \(error)")
                    completion(false)
                    return
                }
                completion(true)
            }
    }
}
