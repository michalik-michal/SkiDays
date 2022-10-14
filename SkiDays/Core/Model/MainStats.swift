import Foundation
import FirebaseFirestoreSwift
import SwiftUI
import Charts

struct MainStats: Identifiable {
    
    var id: String = UUID().uuidString
    var numberOfDays: Int?
    var mostSkiedDiscipline: String?
    var mostSkiedDisciplineDays: Int?
    var mostSkiedContidions: String?
    var totalGates: Int?
    var totalRuns: Int?
    var consistency : Double?
}
