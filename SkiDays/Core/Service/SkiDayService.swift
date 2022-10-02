import Firebase
import MobileCoreServices

struct SkiDayService{
    
    func uploadSkiDay(date: String, discipline: String, place: String,conditions:String, runs: Int, gates: Int, consistency: Double, notes: String, slopeProfile: String, skis: String, video: String,completion: @escaping(Bool) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let data = ["uid": uid,
                    "date": date ,
                    "discipline": discipline,
                    "conditions": conditions,
                    "place": place,
                    "runs": runs,
                    "gates": gates,
                    "consistency": consistency,
                    "notes": notes,
                    "slopeProfile": slopeProfile,
                    "skis": skis,
                    "video": video
        ]as [String : Any]
        
        Firestore.firestore().collection("skidays").document()
            .setData(data) { error in
                if let error = error{
                    print("Failed to upload SkiDay wiht errror: \(error)")
                    completion(false)
                    return
                }
                completion(true)
            }
    }
    func fetchSkiDays(completion: @escaping([SkiDay]) -> Void){
        Firestore.firestore().collection("skidays")
            .order(by: "date", descending: true) //hours (?)
            .addSnapshotListener { snapshot, _ in
                guard let documents = snapshot?.documents else {return}
                
                let skiDays = documents.compactMap({try? $0.data(as: SkiDay.self)})
                completion(skiDays)
            }
    }
    func fetchSkiDaysForUid(forUid uid: String, completion: @escaping([SkiDay]) -> Void){
        Firestore.firestore().collection("skidays")
            .whereField("uid", isEqualTo: uid)
            .addSnapshotListener { snapshot, _ in
                guard let documents = snapshot?.documents else {return}
                let skiDays = documents.compactMap({try? $0.data(as: SkiDay.self)})
                completion(skiDays.sorted(by: {$0.date > $1.date}))
            }
    }
    
    func deleteSkiDay(_ skiDay: SkiDay){
        Firestore.firestore().collection("skidays").document(skiDay.id!).delete() { error in
            if let error = error {
                print("Error removing document: \(error)")
            }
        }
    }
}
