//
//  TrainingsList.swift
//  SkiDays
//
//  Created by MacOS on 29/04/2022.
//

import SwiftUI

struct TrainingsListView: View {
    
    @ObservedObject var viewModel = TrainingListViewModel()
    
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
                ForEach(viewModel.skiDays){skiDay in
                    TrainingRowView(skiDay: skiDay)
                }
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
