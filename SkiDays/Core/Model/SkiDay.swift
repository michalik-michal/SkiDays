import FirebaseFirestoreSwift
import Firebase

struct SkiDay: Identifiable, Decodable {

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
    let video: String // Should it be string ?
   // let uid: String - can i get rid of it ?
}
