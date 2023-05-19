import Foundation
import SwiftUI
import PhotosUI

class UploadSkiDayViewModel: ObservableObject {

    @Published var didUploadSkiDay = false
    @Published var selectedVideo: PhotosPickerItem? {
        didSet {
            Task { try await uploadVideo(selectedVideo) }
        }
    }

    let service = SkiDayService()

    func uploadSkiDay(skiDay: SkiDay) {
        service.uploadSkiDay(skiDay: skiDay
        ) { succes in
            if succes {
                self.didUploadSkiDay = true
            } else {
                // show error message
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

    func uploadVideo(_ video: PhotosPickerItem?) async throws {
        guard let item = video else { return }
        guard let videoData = try await item.loadTransferable(type: Data.self) else { return }
        guard let videoURL = try await service.uploadVideo(videoData) else { return }
        print(videoURL)
        print("----")
    }
}
