//
//  VideoPicker.swift
//  SkiDays
//
//  Created by MacOS on 05/06/2022.
//

import SwiftUI

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
            //ulpoad image to firebase
            picker.dismiss(animated: true)
        }
    }

}


