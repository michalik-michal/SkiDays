import Foundation
import SwiftUI
import PhotosUI

class UploadSkiDayViewModel: ObservableObject {

    @Published var didUploadSkiDay = false
    @Published var selectedVideo: PhotosPickerItem?

    let service = SkiDayService()

    func uploadSkiDay(skiDay: SkiDay) {
        if selectedVideo != nil {
            Task { if let videoURL = try await uploadVideo(selectedVideo) {
                var skiDayData = skiDay
                skiDayData.video = videoURL
                service.uploadSkiDay(skiDay: skiDayData) { succes in
                    if succes {
                        self.didUploadSkiDay = true
                    } else {
                        // show error message
                    }
                }
            } }
        } else {
            service.uploadSkiDay(skiDay: skiDay) { succes in
                if succes {
                    self.didUploadSkiDay = true
                } else {
                    // show error message
                }
            }
        }
    }

    func provideTitle(_ discipline: String) -> String {
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
            return "Add Training"
        }
    }

    func uploadVideo(_ video: PhotosPickerItem?) async throws -> String? {
        guard let item = video else { return nil }
        guard let videoData = try await item.loadTransferable(type: Data.self) else { return nil }
        guard let videoURL = try await service.uploadVideo(videoData) else { return nil }
        return videoURL
    }
}
