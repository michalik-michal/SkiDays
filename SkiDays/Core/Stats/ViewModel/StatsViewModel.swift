import Foundation
import SwiftUI

class StatsViewModel: ObservableObject{
    
    @Published var stats = [DisciplineStats]()
    var skiDays = [SkiDay]()
    let service = StatsService()
    let user: User
    var disciplines = ["ALL", "SL", "GS", "SG", "DH", "PARA", "FREE"]
    let gradient = Gradient(colors: [.pastelGreen, .pastelBlue, .pastelYellow, .pastelOrange, .pastelPurple, .pastelRed])

    init(user: User){
        self.user = user
        self.fetchUserSkidays()
        getStats()
    }
    
    func fetchUserSkidays(){
        guard let uid = user.id else {return}
        service.fetchSkiDaysForUid(forUid: uid) { skiDays in
            self.skiDays = skiDays
        }
    }
    
    func getStats(){
        stats = []
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            for discipline in self.disciplines {
                let filteredSkiDays = self.skiDays.filter({
                    $0.discipline.contains(discipline)
                })
                let discilpineDays = filteredSkiDays.count
                var totalGates = 0
                var totalRuns = 0
                var averageGates = 0
                var averageRuns = 0
                
                for skiDay in self.skiDays{
                    
                    if skiDay.discipline == discipline{
                        totalRuns = totalRuns + skiDay.runs
                        
                        totalGates = totalGates + skiDay.gates *  skiDay.runs
                    }
                }
                
                if discilpineDays != 0{
                    averageRuns = totalRuns / discilpineDays
                    averageGates = totalGates / discilpineDays
                }
                
                let stat = (DisciplineStats(
                    discipline: discipline,
                    numberOfDays: discilpineDays,
                    totalRuns: totalRuns,
                    totalGates: totalGates,
                    averageRuns: averageRuns,
                    averageGates: averageGates))
                
                self.stats.append(stat)
            }
        }
    }
    
    func getStatsFor(_ discipline: String) -> DisciplineStats {
            let filteredSkiDays = self.skiDays.filter({
                $0.discipline.contains(discipline)
            })
            let discilpineDays = filteredSkiDays.count
            var totalGates = 0
            var totalRuns = 0
            var averageGates = 0
            var averageRuns = 0
            
            for skiDay in self.skiDays{
                
                if skiDay.discipline == discipline{
                    totalRuns = totalRuns + skiDay.runs
                    
                    totalGates = totalGates + skiDay.gates *  skiDay.runs
                }
            }
            
            if discilpineDays != 0{
                averageRuns = totalRuns / discilpineDays
                averageGates = totalGates / discilpineDays
            }
            
            let stat = (DisciplineStats(
                discipline: discipline,
                numberOfDays: discilpineDays,
                totalRuns: totalRuns,
                totalGates: totalGates,
                averageRuns: averageRuns,
                averageGates: averageGates))
            return stat
    }
    
    func getCapsuleColor(for discipline: String) -> Color {
        switch discipline{
        case "ALL": return .blue
        case "SL": return .pastelGreen
        case "GS": return .pastelBlue
        case "SG": return .pastelYellow
        case "DH": return .pastelOrange
        case "PARA": return .pastelPurple
        case "FREE": return .pastelRed
        default: return .gray
        }
    }
}
