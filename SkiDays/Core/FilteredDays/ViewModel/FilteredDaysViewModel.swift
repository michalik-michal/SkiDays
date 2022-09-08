import Foundation

class FilteredDaysViewModel: ObservableObject {
    
    @Published var skiDays = [SkiDay]()
    
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
}
