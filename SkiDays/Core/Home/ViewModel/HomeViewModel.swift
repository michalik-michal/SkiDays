import SwiftUI

class HomeViewModel: ObservableObject {

    @Published var skiDays = [SkiDay]()
    @Published var disciplineFilter = ""
    @Published var state = State.loading
    @Published var mainStats = MainStats()

    let service = SkiDayService()
    let user: User
    let statsViewModel: StatsViewModel

    init(user: User) {
        self.user = user
        self.statsViewModel = StatsViewModel(user: user)
        self.fetchUserSkidays()
        self.getMainStats()
    }

    enum State {
        case loading
        case data
    }

    func fetchUserSkidays() {
        guard let uid = user.id else {return}
        service.fetchSkiDaysForUid(forUid: uid) { skiDays in
            self.skiDays = skiDays
            self.state = .data
        }
    }

    func numberOfDisciplineDays( _ discipline: String) -> Int {
        let filteredSkiDays = skiDays.filter({
            $0.discipline.contains(discipline)
        })
        return filteredSkiDays.count
    }

    func getTitle() -> String {
        switch skiDays.count {
        case 1:
            return "DAY"
        default:
            return "DAYS"
        }
    }

    func getLastNote() -> String {
        let sortedDays = skiDays.sorted(by: {$0.date > $1.date})
        for skiDay in sortedDays {
            if skiDay.notes != "" {
                return skiDay.notes
            } else {
                continue
            }
        }
        return ""
    }

    func getMainStats() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            var totalGates = 0
            var totalRuns = 0
            var hardConsistency = 0.0
            var consistency = 0.0
            var days: [Int] = []
            var daysOnGates: Int = 0

            for skiDay in self.skiDays {
                totalRuns += skiDay.runs
                totalGates +=  skiDay.gates *  skiDay.runs
                if skiDay.discipline != "FREE" {
                    hardConsistency += skiDay.consistency
                }
            }
            for discipline in self.statsViewModel.disciplineStats {
                days.append(discipline.numberOfDays)
            }
            for skiDay in self.skiDays where skiDay.discipline != "FREE"{
                daysOnGates += 1
            }
            if !self.skiDays.isEmpty {
                consistency = hardConsistency / Double(daysOnGates)
            }
            self.mainStats = MainStats(numberOfDays: self.skiDays.count,
                                       mostSkiedDiscipline: self.statsViewModel.getMostSkiedDiscipline(),
                                       mostSkiedDisciplineDays: self.statsViewModel.getMostSkiedDisciplineDaysCount(),
                                       mostSkiedContidions: self.statsViewModel.getMostSkiedConditions(),
                                       totalGates: totalGates,
                                       totalRuns: totalRuns,
                                       consistency: consistency)
        }
    }
}
