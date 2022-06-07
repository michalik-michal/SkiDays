//
//  VideoPicker.swift
//  SkiDays
//
//  Created by MacOS on 05/06/2022.
//

import SwiftUI
import Firebase

struct VideoPicker: UIViewControllerRepresentable{

    @Binding var video: UIImage
    
    func makeUIViewController(context: Context) -> UIImagePickerController {


        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.mediaTypes = ["public.movie"]
        
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context){}

    func makeCoordinator() -> Coordinator {
        return Coordinator(videoPicker: self)
    }

    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        
        let videoPicker: VideoPicker
        
        init(videoPicker: VideoPicker){
            self.videoPicker = videoPicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            guard let uid = Firebase.Auth.auth().currentUser?.uid else {return}
            let filename = uid + ".mov"
            let ref = Storage.storage().reference().child("videos").child(filename)
            if let url = info[.mediaURL] as? URL {
                
                ref.putFile(from: url, metadata: nil) { metadata, error in
                    if let error = error{
                        print("failed to upload video -- ",error)
                        return
                    }
                    ref.downloadURL { downloadUrl, error in
                        if let error = error{
                            print("error while generating download url", error)
                            return
                        }
                        guard let url = downloadUrl?.absoluteString else {return}
                        print("URLLLLL", url)
                    }
                }
            }
            picker.dismiss(animated: true)
        }
    }
}


