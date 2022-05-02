//
//  TrainingRowView.swift
//  SkiDays
//
//  Created by MacOS on 29/04/2022.
//

import SwiftUI

struct TrainingRowView: View {
    
    var date: String
    var discipline: String
    var hasVideo: Bool
    var place: String
    var conditions: String
    
    var body: some View {
        
        HStack{
            VStack(spacing: 30){
                Text(date)
                    .font(.system(size: 20))
                    .frame(width: 120)
                Text("📍\(place)")
                    .frame(width: 120)
                    .font(.system(size: 20))
            }
            
            Spacer()
            
            NavigationLink{
                TrainingDetailsView()
            }label: {
                Text(discipline)
                    .bold()
                    .frame(width: 80)
                    .font(.system(size: 25))
            }
            
                
            
           Spacer()
            
            VStack(spacing:30){
                Image(systemName: "video")
                
                    .frame(width: 120)
                
                    .font(.system(size: 20))
                    .foregroundColor(hasVideo == true ? .white : .clear)
                Text(conditions)
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

struct TrainingRowView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingRowView(date: "03/12/22", discipline: "FREE", hasVideo: true, place: "Obdach", conditions: "Icy")
    }
}
