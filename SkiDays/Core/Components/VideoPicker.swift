//
//  VideoPicker.swift
//  SkiDays
//
//  Created by MacOS on 05/06/2022.
//

import SwiftUI
import Photos
import AVKit
//struct VideoPicker: UIViewControllerRepresentable{
//
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//
//
//        let picker = UIImagePickerController()
//
//
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context){}
//
//    typealias UIViewControllerType = UIImagePickerController
//
//
//}
class ImagePickerViewModel: NSObject,ObservableObject,PHPhotoLibraryChangeObserver{
    
    @Published var showImagePicker = false
    @Published var libraryStatus = LibraryStatus.denied
    @Published var fetchedPhotos : [Asset] = []
    @Published var allPhotos: PHFetchResult<PHAsset>!
    
    //Preview
    @Published var showPreview = false
    @Published var selectedImagePreview: UIImage!
    @Published var selectedVideoPreview: AVAsset!
    
    func openImagePicker(){
        
        withAnimation {
            showImagePicker.toggle()
            
            if fetchedPhotos.isEmpty{
                fetchPhotos()
            }
        }
    }
    func setUp(){
        
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { [self] (status) in
            
            DispatchQueue.main.async {
                switch status{
                    
                case .denied:
                    self.libraryStatus = .denied
                case .authorized:
                    self.libraryStatus = .approved
                case .limited:
                    self.libraryStatus = .limited
                default:
                    self.libraryStatus = .denied
                }
            }
         }
        PHPhotoLibrary.shared().register(self)
        
    }
    

    func photoLibraryDidChange(_ changeInstance: PHChange) {
        
        guard let _ = allPhotos else {return}
        
        if let updates = changeInstance.changeDetails(for: allPhotos){
            let updatedPhotos = updates.fetchResultAfterChanges
            
            updatedPhotos.enumerateObjects { [self](asset, index, _) in
                if !allPhotos.contains(asset){
                    getImageFromAsset(asset: asset, size: CGSize(width: 150, height: 150)) { image in
                        DispatchQueue.main.async {
                            self.fetchedPhotos.append(Asset(asset: asset, image: image))
                        }
                    }
                }
            }
            allPhotos.enumerateObjects { [self](asset, index, _) in
                if updatedPhotos.contains(asset){
                    DispatchQueue.main.async {
                        self.fetchedPhotos.removeAll{(result) -> Bool in
                            return result.asset == asset
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                self.allPhotos = updatedPhotos
            }
        }
    }
    
    func fetchPhotos(){
        
        let options = PHFetchOptions()
        options.sortDescriptors = [
        
            NSSortDescriptor(key: "creationDate", ascending: false)
        ]
        options.includeHiddenAssets = false
        let fetchResults = PHAsset.fetchAssets(with: options)
        
        allPhotos = fetchResults
        
        fetchResults.enumerateObjects { [self]asset, index, _ in
            
            getImageFromAsset(asset: asset, size: CGSize(width: 150, height: 150)) { image in
                
                self.fetchedPhotos.append(Asset(asset: asset, image: image))
            }
            
        }
    }
    
    func getImageFromAsset(asset: PHAsset,size: CGSize, completion: @escaping(UIImage) ->()){
        let imageManager = PHCachingImageManager()
        imageManager.allowsCachingHighQualityImages = true
        
        let imageOptions = PHImageRequestOptions()
        imageOptions.deliveryMode = .highQualityFormat
        imageOptions.isSynchronous = false
        
        let size = CGSize(width: 150, height: 150)
        
        imageManager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: imageOptions) { image, _ in
            guard let resizedImage = image else {return}
            
            completion(resizedImage)
        }
    }
    
    
    func extractPreviewData(asset: PHAsset){
        
        let manager = PHCachingImageManager()
        
        if asset.mediaType == .image{
            
            getImageFromAsset(asset: asset, size: PHImageManagerMaximumSize) { (image) in
                DispatchQueue.main.async {
                    self.selectedImagePreview = image
                }
            }
        }
        
        if asset.mediaType == .video{
            
            
            let videoManager = PHVideoRequestOptions()
            videoManager.deliveryMode = .highQualityFormat
            
            manager.requestAVAsset(forVideo: asset, options: videoManager) { videoAsset, _, _ in
                guard let videoUrl = videoAsset else{return}
                
                DispatchQueue.main.async {
                    self.selectedVideoPreview = videoUrl
                }
            }
        }
        
    }
}



enum LibraryStatus{
    
    case denied
    case approved
    case limited
    
}


