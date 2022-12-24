import FirebaseFirestoreSwift
import Firebase

struct RaceDay: Identifiable, Decodable, Equatable {

    @DocumentID var id: String?

    var date: String
    let discipline: String
    let notes: String
    let place: String
    let conditions: String
    let slopeProfile: String
    let skis: String
    let video: String
    let points: String
}
