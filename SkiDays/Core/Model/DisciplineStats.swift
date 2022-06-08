//
//  DisciplineStats.swift
//  SkiDays
//
//  Created by MacOS on 07/06/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct DisciplineStats: Identifiable{

    var id: String = UUID().uuidString
    var discipline: String
    var numberOfDays: Int
    var totalRuns: Int
    var totalGates: Int
    var averageRuns: Int
    var averageGates: Int
    
}
