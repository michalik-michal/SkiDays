//
//  VideoPicker.swift
//  SkiDays
//
//  Created by MacOS on 05/06/2022.
//

import SwiftUI
import Firebase
import FirebaseStorage
import AVFoundation
import MobileCoreServices

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
        
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//            if let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL{
//                //print(videoURL, "file url")
//                let filename = "someFilename.mov"
//
//                Storage.storage().reference().child(filename).putFile(from: videoURL as URL, metadata: nil, completion: {(metadata, error) in
//                    if error != nil {
//                        print("failed uploading video:", error)
//                    }
//                    if let storageURL = metadata?.storageReference?.downloadURL{
//                        print(storageURL)
//                    }
//
//                })
//
//            }
//
//            picker.dismiss(animated: true)
//        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL{
                print("THIS IS URL =====")
                print(url)
                uploadToCloud(fileURL: url)
            }
            picker.dismiss(animated: true)
        }
        func uploadToCloud(fileURL: URL){
            let storage = Storage.storage()
            let data = Data()
            let storageRef = storage.reference()
            
            let localFile = fileURL
            
            let videoRef = storageRef.child("UploadVideoOne")
            
            
            let uploadTask = videoRef.putFile(from: localFile, metadata: nil) { metadata, err in
                guard let meatadata = metadata else{
                    print("ERROR---")
                    print(err)
                    return
                }
                print("video UPLOADED ")
            }
        }
    }
    
}


