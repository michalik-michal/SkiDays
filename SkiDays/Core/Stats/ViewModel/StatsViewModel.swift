import Foundation
import SwiftUI

class StatsViewModel: ObservableObject{
    
    @Published var stats = [DisciplineStats]()
    var skiDays = [SkiDay]()
    let service = StatsService()
    let user: User
    var disciplines = ["SL", "GS", "SG", "DH", "PARA", "FREE"]
    
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
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
}
