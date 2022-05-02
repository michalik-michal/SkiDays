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
                    .frame(width: 120)
                Text("📍\(skiDay.place)")
                    .frame(width: 120)
                    .font(.system(size: 20))
            }
            
            Spacer()
            
            NavigationLink{
                TrainingDetailsView()
            }label: {
                Text(skiDay.discipline)
                    .bold()
                    .frame(width: 80)
                    .font(.system(size: 25))
            }
            
           Spacer()
            
            VStack(spacing:30){
                Image(systemName: "video")
                
                    .frame(width: 120)
                
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                Text(skiDay.conditions)
                    .frame(width: 120)
                    .font(.system(size: 20))
            }
        }
        .foregroundColor(.white)
        .padding(.vertical, 30)
        .background(Color.darkerBlue)
        .cornerRadius(20)
    }
}
//
//struct TrainingRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrainingRowView(skiDay: <#SkiDay#>, date: "03/12/22", discipline: "FREE", hasVideo: true, place: "Obdach", conditions: "Icy")
//    }
//}
