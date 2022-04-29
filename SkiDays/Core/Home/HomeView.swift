//
//  HomeView.swift
//  SkiDays
//
//  Created by MacOS on 29/04/2022.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
           ScrollView {
                VStack(){
                    NavigationLink {
                        StatsView()
                    } label: {
                        Text("ALL: 42")
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
                            DisciplineButtonView(discipline: "SL", days: 20)
                            DisciplineButtonView(discipline: "GS", days: 11)
                        }
                        HStack(spacing: 30){
                            DisciplineButtonView(discipline: "SG", days: 5)
                            DisciplineButtonView(discipline: "DH", days: 14)
                        }
                        HStack(spacing: 30){
                            
                            DisciplineButtonView(discipline: "FREE", days: 10)
                            DisciplineButtonView(discipline: "PARA", days: 2)
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
