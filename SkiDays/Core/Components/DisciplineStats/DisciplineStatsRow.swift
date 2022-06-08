//
//  DisciplineStatsRow.swift
//  SkiDays
//
//  Created by MacOS on 07/06/2022.
//

import SwiftUI

struct DisciplineStatsRow: View {
    
    var discipline: DisciplineStats
    
    var body: some View {
        VStack(spacing: 10){
            HStack{
                Text(discipline.discipline)
                    .font(.largeTitle).bold()
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
            HStack{
                VStack(alignment: .leading,spacing: 10){
                    Text("Total runs: \(discipline.totalRuns)")
                        .font(.system(size: 20))
                    Text("Total gates: \(discipline.totalGates)")
                        .font(.system(size: 20))
                }
                Spacer()
                VStack(alignment: .leading,spacing: 10){
                    Text("Average runs: \(discipline.averageRuns)")
                        .font(.system(size: 20))
                    Text("Average gates: \(discipline.averageGates)")
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
        DisciplineStatsRow(discipline: DisciplineStats(discipline: "SL", numberOfDays: 10, totalRuns: 100, totalGates: 10000, averageRuns: 10, averageGates: 30))
    }
}
