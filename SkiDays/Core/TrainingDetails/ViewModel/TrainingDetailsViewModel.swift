import Foundation

class TrainingDetailsViewModel: ObservableObject {

    let service = SkiDayService()

    func deleteSkiDay(_ skiDay: SkiDay) {
        service.deleteVideo(skiDay.video)
        service.deleteSkiDay(skiDay)
    }
}
