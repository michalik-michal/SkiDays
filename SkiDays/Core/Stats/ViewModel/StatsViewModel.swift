//
//  StatS.swift
//  SkiDays
//
//  Created by MacOS on 07/06/2022.
//

import Foundation

class StatsViewModel: ObservableObject{
    
    @Published var stats = [DisciplineStats]()
    var skiDays = [SkiDay]()
    let service = StatsService()
    let user: User
    
    
    init(user: User){
        self.user = user
        self.fetchUserSkidays()
        getStats(for: "SL")
        
    }
    
    func fetchUserSkidays(){
        guard let uid = user.id else {return}
        service.fetchSkiDaysForUid(forUid: uid) { skiDays in
            self.skiDays = skiDays
            
        }
    }
    func getStats(for discipline: String){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
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
                    totalRuns += totalRuns + skiDay.runs
                    totalGates += totalRuns + skiDay.gates
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
