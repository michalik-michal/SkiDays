//
//  VideoPicker.swift
//  SkiDays
//
//  Created by MacOS on 05/06/2022.
//

import SwiftUI

struct VideoPicker: UIViewControllerRepresentable{

    func makeUIViewController(context: Context) -> UIImagePickerController {


        let picker = UIImagePickerController()


        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context){}

    typealias UIViewControllerType = UIImagePickerController


}


