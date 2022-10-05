import Foundation
import FirebaseFirestoreSwift
import SwiftUI
import Charts

struct DisciplineStats: Identifiable{
    
    var id: String = UUID().uuidString
    var discipline: String
    var numberOfDays: Int
    var totalRuns: Int
    var totalGates: Int
    var averageRuns: Int
    var averageGates: Int
    var consistency: Double
    var animate: Bool = false
}
