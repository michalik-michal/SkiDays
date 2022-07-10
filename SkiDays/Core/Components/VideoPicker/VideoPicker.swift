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

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL{
                uploadVideo(with: url)
            }
            picker.dismiss(animated: true)
        }
        func uploadVideo(with fileURL: URL){
                let storage = Storage.storage()
                //let data = Data()
                let storageRef = storage.reference()
                
                let localFile = fileURL
                
                let videoRef = storageRef.child("UploadVideoOne")
                
                
                let uploadTask = videoRef.putFile(from: localFile, metadata: nil) { metadata, err in
                    guard let meatadata = metadata else{
                        print("error")
                        return
                    }
                    print("video UPLOADED ")
                }
            }
    }
}


