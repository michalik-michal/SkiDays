//
//  SkiDay.swift
//  SkiDays
//
//  Created by MacOS on 02/05/2022.
//

import FirebaseFirestoreSwift
import Firebase

struct SkiDay: Identifiable, Decodable{
    
    @DocumentID var id: String?
    
    var date: String
    let discipline: String
    let gates: Int
    let notes: String
    let place: String
    let runs: Int
    let conditions: String
    

    let uid: String
    
    // video 
}
