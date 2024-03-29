import Foundation
import SwiftUI

class StatsViewModel: ObservableObject {

    @Published var disciplineStats = [DisciplineStats]()
    var skiDays = [SkiDay]()
    let service = StatsService()
    let user: User
    var disciplines = ["SL", "GS", "SG", "DH", "PARA", "FREE"]
    var conditions = ["Snow", "-", "Soft", "Grippy", "Bumpy", "Hard", "Compact", "Ice", "Rats", "Salt"]
    var statCategories = ["ALL", "SL", "GS", "SG", "DH", "PARA", "FREE"]

    init(user: User) {
        self.user = user
        self.fetchUserSkidays()
        self.getStats()
    }

    func fetchUserSkidays() {
        guard let uid = user.id else {return}
        service.fetchSkiDaysForUid(forUid: uid) { skiDays in
            self.skiDays = skiDays
        }
    }

    func getStats() {
        disciplineStats = []
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
                var hardConsistency = 0.0
                var consistency = 0.0
                for skiDay in self.skiDays where skiDay.discipline == discipline {
                        totalRuns += skiDay.runs
                        totalGates += skiDay.gates *  skiDay.runs
                        hardConsistency += skiDay.consistency
                }

                if discilpineDays != 0 {
                    averageRuns = totalRuns / discilpineDays
                    averageGates = totalGates / discilpineDays
                }
                consistency = hardConsistency / Double(discilpineDays)

                let stat = (DisciplineStats(
                    discipline: discipline,
                    numberOfDays: discilpineDays,
                    totalRuns: totalRuns,
                    totalGates: totalGates,
                    averageRuns: averageRuns,
                    averageGates: averageGates,
                    consistency: consistency,
                    mostSkiedContidions: ""))

                self.disciplineStats.append(stat)
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
        var hardConsistency = 0.0
        var consistency = 0.0

        for skiDay in self.skiDays where skiDay.discipline == discipline {
                totalRuns += skiDay.runs
                totalGates += skiDay.gates *  skiDay.runs
                hardConsistency += skiDay.consistency
        }
        if discilpineDays != 0 {
            averageRuns = totalRuns / discilpineDays
            averageGates = totalGates / discilpineDays
            consistency = hardConsistency / Double(discilpineDays)
        }
        let stat = (DisciplineStats(
            discipline: discipline,
            numberOfDays: discilpineDays,
            totalRuns: totalRuns,
            totalGates: totalGates,
            averageRuns: averageRuns,
            averageGates: averageGates,
            consistency: consistency,
            mostSkiedContidions: getMostSkiedConditionsForDiscipline(for: discipline)))
        return stat
    }

    func getMostSkiedConditions() -> String {
        var dictionary: [String: Int] = [:]
        for condition in conditions {
            dictionary[condition] = 0
        }
        for skiDay in skiDays {
            dictionary[skiDay.conditions]! += 1
        }
        let sorted = dictionary.sorted { $0.1 > $1.1 }
        if sorted[0].value == 0 { return "-" }
        return sorted[0].key
    }

    func getMostSkiedDiscipline() -> String {
        var dictionary: [String: Int] = [:]
        for discipline in disciplines {
            dictionary[discipline] = 0
        }
        for skiDay in skiDays {
            dictionary[skiDay.discipline]! += 1
        }
        var sum = 0
        for number in dictionary.values {
            sum += number
        }
        if sum == 0 { return "-" }
        let sorted = dictionary.sorted {$0.1 > $1.1}
        return sorted[0].key
    }

    func getMostSkiedDisciplineDaysCount() -> Int {
        var dictionary: [String: Int] = [:]
        for discipline in disciplines {
            dictionary[discipline] = 0
        }
        for skiDay in skiDays {
            dictionary[skiDay.discipline]! += 1
        }
        return dictionary.values.max() ?? 0
    }

    func getMostSkiedConditionsForDiscipline(for discipline: String) -> String {
        var dictionary: [String: Int] = [:]
        for condition in conditions {
            dictionary[condition] = 0
        }
        for skiDay in skiDays where skiDay.discipline == discipline {
                dictionary[skiDay.conditions]! += 1
        }
        var sum = 0
        for number in dictionary.values {
            sum += number
        }
        if sum == 0 { return "-" }
        let sorted = dictionary.sorted { $0.1 > $1.1 }
        return sorted[0].key
    }

    func getCapsuleColor(for discipline: String) -> Color {
        switch discipline {
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
