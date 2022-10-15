import Foundation

class TrainingDetailsViewModel: ObservableObject {

    let service = SkiDayService()

    func deleteSkiDay(_ skiDay: SkiDay) {
        service.deleteSkiDay(skiDay)
    }
}
