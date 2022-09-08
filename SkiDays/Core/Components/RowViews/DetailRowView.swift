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
            .foregroundColor(.blackWhite)
            .frame(height: 80)
            .frame(maxWidth: .infinity)
            .font(.system(size: 20))
            .background(Color.secondayBackground)
            .cornerRadius(12)
    }
}

struct DetailRowView_Previews: PreviewProvider {
    static var previews: some View {
        DetailRowView(text: "SL")
    }
}
