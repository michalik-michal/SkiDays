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
    static let background = Color("background")
    static let secondayBackground = Color("secondaryBackground")
    static let blackWhite = Color("blackWhite")
}


extension View {
   func endTextEditing() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                    to: nil, from: nil, for: nil)
  }
}
