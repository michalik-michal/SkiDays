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
//                HStack{
//                    backButton
//                    Spacer()
//                }
                HStack{
                    Text("Statistics")
                        .font(.largeTitle).bold()

                    Spacer()
                }
                Circle()
                    .fill(.green)
                    .frame(width: 250, height: 250)
                    .padding(.bottom, 30)
                    .overlay {
                        Text("Add Chart")
                            .foregroundColor(.white)
                    }
                VStack(spacing: 30){
                    ForEach(viewModel.stats){stat in
                            DisciplineStatsRow(stats: stat)
                    }
                }
            }
        }
        .padding()
        .padding(.top, 30)
        .background(Color.background)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
        
        
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(user: User(id: "123", username: "meszkos", fullname: "meszkos", email: "meszkos", uid: "123"))
    }
}

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
