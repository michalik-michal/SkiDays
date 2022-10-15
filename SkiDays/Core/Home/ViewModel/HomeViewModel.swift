import SwiftUI

class HomeViewModel: ObservableObject {

    @Published var skiDays = [SkiDay]()
    @Published var disciplineFilter = ""

    let service = SkiDayService()
    let user: User

    init(user: User) {
        self.user = user
        self.fetchUserSkidays()
    }

    func fetchUserSkidays() {
        guard let uid = user.id else {return}
        service.fetchSkiDaysForUid(forUid: uid) { skiDays in
            self.skiDays = skiDays
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

    func getColors() -> [Color] {
        var circleColors: [Color] = []
        let sortedDays = skiDays.sorted {
            $0.discipline < $1.discipline
        }
        if skiDays.count < 2 {
            circleColors.append(.secondayBackground)
        } else {
            for day in sortedDays {
                switch day.discipline {
                case "SL":
                    circleColors.append(.pastelGreen)
                case "GS":
                    circleColors.append(.pastelBlue)
                case "SG":
                    circleColors.append(.pastelYellow)
                case "DH":
                    circleColors.append(.pastelOrange)
                case "PARA":
                    circleColors.append(.pastelPurple)
                case "FREE":
                    circleColors.append(.pastelRed)
                default:
                    circleColors.append(.white)
                }
            }
            if let connectingColor = circleColors.first {
                circleColors.append(connectingColor)
            }
        }
        return circleColors
    }
}
