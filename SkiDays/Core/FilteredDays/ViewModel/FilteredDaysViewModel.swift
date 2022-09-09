import Foundation

class FilteredDaysViewModel: ObservableObject {
    
    @Published var skiDays = [SkiDay]()
    
    let service = SkiDayService()
    let user: User
    let discipline: String
    
    var title: String {
        switch discipline {
        case "SL":
            return "Slalom"
        case "GS":
            return "Giant Slalom"
        case "SG":
            return "Super G"
        case "DH":
            return "Downhill"
        case "FREE":
            return "Free Skiing"
        case "PARA":
            return "Paralell"
        default:
            return ""
        }
    }
    
    init(user: User, discipline: String) {
        self.user = user
        self.discipline = discipline
        self.fetchUserSkidays()
    }
    
    func fetchUserSkidays() {
        guard let uid = user.id else {return}
        service.fetchSkiDaysForUid(forUid: uid) { skiDays in
            self.skiDays = skiDays
        }
    }
}
