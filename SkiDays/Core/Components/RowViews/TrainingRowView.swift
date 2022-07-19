//
//  TrainingRowView.swift
//  SkiDays
//
//  Created by MacOS on 29/04/2022.
//

import SwiftUI

struct TrainingRowView: View {
    
    let skiDay: SkiDay

    var body: some View {
        
        HStack{
            VStack(spacing: 30){
                Text("\(skiDay.date)")
                    .font(.system(size: 20))
                    .frame(width: 100)
                Text("📍\(skiDay.place)")
                    .lineLimit(0)
                    .frame(width: 100)
                    .font(.system(size: 20))
            }
            
            Spacer()
            
            NavigationLink{
                TrainingDetailsView(skiDay: skiDay)
                
            }label: {
                Text(skiDay.discipline)
                    .bold()
                    .frame(width: 80)
                    .font(.system(size: 25))
            }
            
           Spacer()
            
            VStack(spacing:30){
                Image(systemName: "video")
                    .frame(width: 100)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                Text(skiDay.conditions)
                    .frame(width: 100)
                    .font(.system(size: 20))
            }
        }
        .padding(.horizontal)
        .foregroundColor(.white)
        .padding(.vertical, 30)
        .background(Color.darkerBlue)
        .cornerRadius(20)
    }
}

struct TrainingRowView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingRowView(skiDay: SkiDay(date: "11/08/22", discipline: "SL", gates: 12, notes: "es", place: "Sierra nevada", runs: 0, conditions: "bad", uid: "1234"))
    }
}
