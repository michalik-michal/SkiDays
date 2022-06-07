//
//  DisciplineStatsRow.swift
//  SkiDays
//
//  Created by MacOS on 07/06/2022.
//

import SwiftUI

struct DisciplineStatsRow: View {
    
    var discipline: String
    
    var body: some View {
        VStack(spacing: 10){
            HStack{
                Text(discipline)
                    .font(.largeTitle).bold()
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
            HStack{
                VStack(alignment: .leading,spacing: 10){
                    Text("Total runs: 80")
                        .font(.system(size: 20))
                    Text("Total gates: 301")
                        .font(.system(size: 20))
                }
                Spacer()
                VStack(alignment: .leading,spacing: 10){
                    Text("Average runs: 4")
                        .font(.system(size: 20))
                    Text("Average gates: 53")
                        .font(.system(size: 20))
                }
            }
            
            .padding()
        }
        .background(Color.darkerBlue)
        .foregroundColor(.white)
        .cornerRadius(20)
        
        
    }
}

struct DisciplineStatsRow_Previews: PreviewProvider {
    static var previews: some View {
        DisciplineStatsRow(discipline: "Slalom")
    }
}
