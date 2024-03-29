import FirebaseFirestoreSwift
import Firebase

struct SkiDay: Identifiable, Decodable, Equatable {

    @DocumentID var id: String?

    var date: String
    let discipline: String
    let gates: Int
    let notes: String
    let place: String
    let runs: Int
    let consistency: Double
    let conditions: String
    let slopeProfile: String
    let skis: String
    var video: String
}
