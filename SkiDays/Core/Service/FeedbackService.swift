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

    func uploadMessage(email: String, _ message: String, completion: @escaping(Bool) -> Void) {
        let data = ["email": email, "message": message] as [String: Any]
        Firestore.firestore().collection("message").document()
            .setData(data) { error in
                if let error = error {
                    print("Failed to upload message \(error)")
                    completion(false)
                    return
                }
                completion(true)
            }
    }
}
