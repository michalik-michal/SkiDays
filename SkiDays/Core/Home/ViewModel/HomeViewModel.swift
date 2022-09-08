import Foundation

class HomeViewModel: ObservableObject{
    
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
    
        
}
