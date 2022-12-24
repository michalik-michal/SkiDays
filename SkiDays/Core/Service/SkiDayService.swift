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
                    print("Failed to upload SkiDay with errror: \(error)")
                    completion(false)
                    return
                }
                completion(true)
            }
    }

    func uploadRaceDay(raceDay: RaceDay, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let data = ["uid": uid,
                    "date": raceDay.date,
                    "notes": raceDay.notes,
                    "place": raceDay.place,
                    "conditions": raceDay.conditions,
                    "slopeProfile": raceDay.slopeProfile,
                    "skis": raceDay.skis,
                    "video": raceDay.video,
                    "points": raceDay.points] as [String: Any]
        Firestore.firestore().collection("racedays").document()
            .setData(data) { error in
                if let error = error {
                    print("Failed to upload RaceDay with errror: \(error)")
                    completion(false)
                    return
                }
                completion(true)
            }
    }

    // swiftlint:disable: line_length
    func fetchSkiDaysForUid(forUid uid: String, completion: @escaping([SkiDay]) -> Void) {
        Firestore.firestore().collection("skidays")
            .whereField("uid", isEqualTo: uid)
            .addSnapshotListener { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let skiDays = documents.compactMap({ try? $0.data(as: SkiDay.self) })
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"

                completion(skiDays.sorted(by: {dateFormatter.date(from: $0.date)! > dateFormatter.date(from: $1.date)!}))
            }
    }

    func fetchRaceDaysForUid(forUid uid: String, completion: @escaping([RaceDay]) -> Void) {
        Firestore.firestore().collection("racedays")
            .whereField("uid", isEqualTo: uid)
            .addSnapshotListener { snapshot, _ in
                guard let documets = snapshot?.documents else { return }
                let raceDays = documets.compactMap({ try? $0.data(as: RaceDay.self) })
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"

                completion(raceDays.sorted(by: {dateFormatter.date(from: $0.date)! > dateFormatter.date(from: $1.date)!}))
            }
    }
    // swiftlint:enable: line_length
    
//    func fetchUserSkiDaysAndRaceDays(forUid uid: String, completion: @escaping([Any]) -> Void) {
//        var results: [Any] = []
//        fetchSkiDaysForUid(forUid: uid) { skiDays in
//            results.append(contentsOf: skiDays)
//        }
//        fetchRaceDaysForUid(forUid: uid) { raceDays in
//            results.append(contentsOf: raceDays)
//        }
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd/MM/yyyy"
//        
//        completion(results.sorted(by: {
//            dateFormatter.date(from: $0.date)! > dateFormatter.date(from: $1.date)!
//            
//        }))
//    }

    func deleteSkiDay(_ skiDay: SkiDay) {
        guard let id = skiDay.id else { return }
        Firestore.firestore().collection("skidays").document(id).delete { error in
            if let error = error {
                print("Error removing document: \(error)")
            }
        }
    }

    func deleteRaceDay(_ raceDay: RaceDay) {
        guard let id = raceDay.id else { return }
        Firestore.firestore().collection("racedays").document(id).delete { error in
            if let error = error {
                print("Error removing document: \(error)")
            }
        }
    }
}
