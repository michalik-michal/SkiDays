//
//  DisciplineStats.swift
//  SkiDays
//
//  Created by MacOS on 07/06/2022.
//

import Foundation

struct DisciplineStats: Identifiable{

    var id: Int { 1 }
    var discipline: String
    var numberOfDays: Int
    var totalRuns: Int
    var totalGates: Int
    var averageRuns: Int
    var averageGates: Int
    
}
