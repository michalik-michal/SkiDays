import Foundation
import Firebase

struct FeedbackService {
    
    func uploadFeedback(_ feedback: String, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let data = [
            "uid": uid,
            "feedback": feedback
        ] as [String: Any]
        
        Firestore.firestore().collection("feedback").document()
            .setData(data) { error in
                if let error = error {
                    print("Failed to upload feedback \(error)")
                    completion(false)
                    return
                }
                completion(true)
            }
    }
}
