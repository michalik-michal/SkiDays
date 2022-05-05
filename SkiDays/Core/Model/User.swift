//
//  User.swift
//  SkiDays
//
//  Created by MacOS on 05/05/2022.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable{
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let email: String
    let uid: String
}
