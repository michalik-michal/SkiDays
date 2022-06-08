//
//  StatsView.swift
//  SkiDays
//
//  Created by MacOS on 29/04/2022.
//

import SwiftUI

struct StatsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: StatsViewModel
    
    init(user: User){
        self.viewModel = StatsViewModel(user: user)
        
    }
    
    var body: some View {
        ScrollView{
            LazyVStack{
                HStack{
                    backButton
                    Spacer()
                }
                HStack{
                    Text("Statistics")
                        .font(.largeTitle).bold()
                        
                    Spacer()
                }
                Circle()
                    .fill(.green)
                    .frame(width: 250, height: 250)
                    .padding(.bottom, 30)
                VStack(spacing: 30){
                    ForEach(viewModel.stats){stat in
                            DisciplineStatsRow(stats: stat)
                    }
                }
            }
        }
        .padding()
        .navigationBarHidden(true)
        
    }
        
}

//struct StatsView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatsView()
//    }
//}

extension StatsView{
    
    var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "arrow.left")
                .foregroundColor(.darkerBlue)
                .font(.system(size: 25))
                .frame(width: 30, height: 30)
                .padding(.top, 15)
                .padding(.bottom, 5)
        }
    }
}
