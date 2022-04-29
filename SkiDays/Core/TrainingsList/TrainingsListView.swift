//
//  TrainingsList.swift
//  SkiDays
//
//  Created by MacOS on 29/04/2022.
//

import SwiftUI

struct TrainingsListView: View {
    var body: some View {
        ScrollView{
            VStack(spacing: 15){
                HStack{
                    Text("All Ski Days")
                        .font(.largeTitle).bold()
                    Spacer()
                    
                    NavigationLink{
                        AddTrainingView()
                    }label: {
                        Image(systemName: "plus")
                            .foregroundColor(.darkerBlue)
                            .font(.system(size: 25))
                            .frame(width: 30, height: 30)
                            
                    }
                }
                .padding(.top, 30)
                TrainingRowView(date: "03/12/22", discipline: "SL", hasVideo: true, place: "Obdach", conditions: "Icy")
                TrainingRowView(date: "02/12/22", discipline: "SL", hasVideo: true, place: "Obdach", conditions: "Icy")
                TrainingRowView(date: "01/12/22", discipline: "GS", hasVideo: false, place: "Obdach", conditions: "Soft")
                TrainingRowView(date: "13/11/22", discipline: "SG", hasVideo: true, place: "Saas Fee", conditions: "Soft")
                TrainingRowView(date: "10/11/22", discipline: "DH", hasVideo: false, place: "Saas Fee", conditions: "Hard")
                TrainingRowView(date: "20/10/22", discipline: "DH", hasVideo: true, place: "Saas Fee", conditions: "Soft")
                TrainingRowView(date: "19/10/22", discipline: "FREE", hasVideo: true, place: "Saas Fee", conditions: "Hard")
                TrainingRowView(date: "18/10/22", discipline: "FREE", hasVideo: false, place: "Hintertux", conditions: "Icy")
                TrainingRowView(date: "17/10/22", discipline: "FREE", hasVideo: true, place: "Hintertux", conditions: "Hard")
            }
        }
        .padding()
        .navigationBarTitle("All Ski Days")
        
    }
}

struct TrainingsList_Previews: PreviewProvider {
    static var previews: some View {
        TrainingsListView()
    }
}
