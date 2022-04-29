//
//  DisciplineButtonView.swift
//  SkiDays
//
//  Created by MacOS on 29/04/2022.
//

import SwiftUI

struct DisciplineButtonView: View {
    
    var discipline: String
    var days: Int
    
    
    var body: some View {
        
        NavigationLink{
            //
        }label: {
            Text("\(discipline): \(days)")
                .foregroundColor(.white)
                .font(.system(size: 35)).bold()
                
        }
        .frame(width: 150, height: 80)
        .background(Color.darkerBlue)
        .cornerRadius(12)
        .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)
        
        
    }
}

struct DisciplineButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DisciplineButtonView(discipline: "SL", days: 12)
    }
}
