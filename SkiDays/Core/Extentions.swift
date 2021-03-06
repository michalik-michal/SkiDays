//
//  Extentions.swift
//  SkiDays
//
//  Created by MacOS on 29/04/2022.
//

import Foundation
import SwiftUI


extension Color{
    static let darkerBlue = Color("darkerBlue")
    static let lightBlue = Color("lightBlue")
    static let buttonColor = Color("buttonColor")
    
}


extension View {
   func endTextEditing() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                    to: nil, from: nil, for: nil)
  }
}
