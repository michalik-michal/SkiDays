import Firebase
import MobileCoreServices

struct SkiDayService {

    func uploadSkiDay(skiDay: SkiDay,
                      completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let data = ["uid": uid,
                    "date": skiDay.date,
                    "discipline": skiDay.discipline,
                    "conditions": skiDay.conditions,
                    "place": skiDay.place,
                    "runs": skiDay.runs,
                    "gates": skiDay.gates,
                    "consistency": skiDay.consistency,
                    "notes": skiDay.notes,
                    "slopeProfile": skiDay.slopeProfile,
                    "skis": skiDay.skis,
                    "video": skiDay.video] as [String: Any]
        Firestore.firestore().collection("skidays").document()
            .setData(data) { error in
                if let error = error {
                    print("Failed to upload SkiDay wiht errror: \(error)")
                    completion(false)
                    return
                }
                completion(true)
            }
    }

    func fetchSkiDays(completion: @escaping([SkiDay]) -> Void) {
        Firestore.firestore().collection("skidays")
            .order(by: "date", descending: true) // hours (?)
            .addSnapshotListener { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let skiDays = documents.compactMap({try? $0.data(as: SkiDay.self)})
                completion(skiDays)
            }
    }
    
    // swiftlint:disable: line_length
    func fetchSkiDaysForUid(forUid uid: String, completion: @escaping([SkiDay]) -> Void) {
        Firestore.firestore().collection("skidays")
            .whereField("uid", isEqualTo: uid)
            .addSnapshotListener { snapshot, _ in
                guard let documents = snapshot?.documents else {return}
                let skiDays = documents.compactMap({try? $0.data(as: SkiDay.self)})
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                
                completion(skiDays.sorted(by: {dateFormatter.date(from: $0.date)! > dateFormatter.date(from: $1.date)!}))
            }
    }
    // swiftlint:enable: line_length

    func deleteSkiDay(_ skiDay: SkiDay) {
        Firestore.firestore().collection("skidays").document(skiDay.id!).delete { error in
            if let error = error {
                print("Error removing document: \(error)")
            }
        }
    }
}
