import Foundation

class TrainingDetailsViewModel: ObservableObject {

    let service = SkiDayService()

    func deleteSkiDay(_ skiDay: SkiDay) {
        if skiDay.video != "" {
            service.deleteVideo(skiDay.video)
        }
        service.deleteSkiDay(skiDay)
    }
}
