import Foundation
import SwiftUI

class UploadSkiDayViewModel: ObservableObject{
    
    @Published var didUploadSkiDay = false
    let service = SkiDayService()
    
//    func uploadSkiDay(date: String,
//                      discipline: String,
//                      place: String,
//                      conditions: String,
//                      runs: Int,
//                      gates: Int,
//                      consistency: Double,
//                      notes: String,
//                      slopeProfile: String,
//                      skis: String,
//                      video: String ) {
    func uploadSkiDay(skiDay: SkiDay) {
        service.uploadSkiDay(skiDay: skiDay
        ) { succes in
            if succes {
                self.didUploadSkiDay = true
            }else {
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
}
