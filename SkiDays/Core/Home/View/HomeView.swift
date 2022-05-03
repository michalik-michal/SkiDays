//
//  HomeView.swift
//  SkiDays
//
//  Created by MacOS on 29/04/2022.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
           ScrollView {
                VStack(){
                    NavigationLink {
                        StatsView()
                    } label: {
                        Text("ALL: \(viewModel.skiDays.count)")
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                    }
                    .frame(width: 300, height: 160)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
                    .padding(.vertical, 70)
                    
                    
                    VStack(spacing: 60){
                        HStack(spacing: 30){
                            DisciplineButtonView(discipline: "SL", days: viewModel.numberOfDisciplineDays("SL"))
                            DisciplineButtonView(discipline: "GS", days: viewModel.numberOfDisciplineDays("GS"))
                        }
                        HStack(spacing: 30){
                            DisciplineButtonView(discipline: "SG", days: viewModel.numberOfDisciplineDays("SG"))
                            DisciplineButtonView(discipline: "DH", days: viewModel.numberOfDisciplineDays("DH"))
                        }
                        HStack(spacing: 30){
                            
                            DisciplineButtonView(discipline: "FREE", days: viewModel.numberOfDisciplineDays("FREE"))
                            DisciplineButtonView(discipline: "PARA", days: viewModel.numberOfDisciplineDays("PARA"))
                        }
                    }
                    
                    
                }
                .frame(maxWidth: .infinity)
                .navigationBarHidden(true)
            }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
