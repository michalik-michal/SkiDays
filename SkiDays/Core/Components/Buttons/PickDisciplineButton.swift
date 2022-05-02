//
//  PickDisciplineButton.swift
//  SkiDays
//
//  Created by MacOS on 30/04/2022.
//

import SwiftUI

struct PickDisciplineButton: View {

        
        var discipline: String
    
        var body: some View {
        Button {
            //
        } label: {
            Text("\(discipline)")
                .foregroundColor(.white)
                .font(.system(size: 20)).bold()
                
        }
        .frame(height: 60)
        .frame(maxWidth: .infinity )
        .background(Color.darkerBlue)
        .cornerRadius(12)
        .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)
        }
}

struct PickDisciplineButton_Previews: PreviewProvider {
    static var previews: some View {
        PickDisciplineButton(discipline: "SL")
    }
}
