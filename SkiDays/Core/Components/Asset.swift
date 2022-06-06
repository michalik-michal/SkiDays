//
//  Asset.swift
//  SkiDays
//
//  Created by MacOS on 05/06/2022.
//

import SwiftUI
import Photos

struct Asset: Identifiable{
    var id = UUID().uuidString
    
    var asset: PHAsset
    var image: UIImage
}
