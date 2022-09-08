import Foundation
import FirebaseFirestore

class TrainingListViewModel: ObservableObject {
    
    @Published var skiDays = [SkiDay]()
    @Published var searchText = ""
    
    private let service = SkiDayService()
    let user: User
    
    init(user: User){
        self.user = user
        self.fetchUserSkidays()
    }

    var searchableSkiDays: [SkiDay] {
        if searchText.isEmpty{
            return skiDays
        } else {
            let lowercasedQuery = searchText.lowercased()
            
            return skiDays.filter({
                $0.place.lowercased().contains(lowercasedQuery)
            })
        }
    }
    
    func fetchUserSkidays() {
        guard let uid = user.id else {return}
        service.fetchSkiDaysForUid(forUid: uid) { skiDays in
            self.skiDays = skiDays
        }
    }
}
