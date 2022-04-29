//
//  DetailRowView.swift
//  SkiDays
//
//  Created by MacOS on 29/04/2022.
//

import SwiftUI

struct DetailRowView: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .frame(height: 80)
            .frame(maxWidth: .infinity)
            .font(.system(size: 20))
            .background(Color.darkerBlue)
            .cornerRadius(12)
            .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)
    }
}

struct DetailRowView_Previews: PreviewProvider {
    static var previews: some View {
        DetailRowView(text: "SL")
    }
}
