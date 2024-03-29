import Firebase
import FirebaseStorage

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

    func deleteSkiDay(_ skiDay: SkiDay) {
        Firestore.firestore().collection("skidays").document(skiDay.id!).delete { error in
            if let error = error {
                print("Error removing document: \(error)")
            }
        }
    }

    func uploadVideo(_ videoData: Data)  async throws -> String? {
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference().child("/videos/\(filename)")

        let metadata = StorageMetadata()
        metadata.contentType = "video/quicktime"

        do {
            _ = try await ref.putDataAsync(videoData, metadata: metadata)
            let url = try await ref.downloadURL()
            return url.absoluteString
        } catch {
            print("Failed to upload video \(error.localizedDescription)")
            return nil
        }
    }

    func deleteVideo(_ url: String) {
        let ref = Storage.storage().reference().storage.reference(forURL: url)
        ref.delete { error in
            if let error = error {
                print("Error deleting video, \(error)")
            }
        }
    }
}
