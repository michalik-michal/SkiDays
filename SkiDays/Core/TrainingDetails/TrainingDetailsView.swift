//
//  TrainingDetailsView.swift
//  SkiDays
//
//  Created by MacOS on 29/04/2022.
//

import SwiftUI

struct TrainingDetailsView: View {
    
    let skiDay: SkiDay
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = DeleteDayViewModel()
    
    var body: some View {
        
            ScrollView{
                HStack{
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.darkerBlue)
                            .font(.system(size: 25))
                            .frame(width: 30, height: 30)
                            .padding(.top, 30)
                            .padding(.bottom, 5)
                    }
                    Spacer()
                }

                HStack{
                    Text(skiDay.date)
                        .font(.title)
                        .bold()
                        
                    Spacer()
                    Text("📍\(skiDay.place)")
                        .font(.title)
                        .bold()
                }
                .padding(.top, 10)
                
                VStack(spacing: 30){
                    
                    HStack{
                        DetailRowView(text: "Giant Slalom")
                        
                        Spacer()
                        DetailRowView(text: skiDay.conditions)
                    }
                    HStack{
                        DetailRowView(text: "\(skiDay.runs) runs")
                        DetailRowView(text: "\(skiDay.gates) gates")
                        DetailRowView(text: "\(skiDay.runs * skiDay.gates) total")

                    }
                    noteView
                    uploadVideoView
                    deleteButton
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .padding(.horizontal)
    }
}

struct TrainingDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingDetailsView(skiDay: SkiDay(id: "xd", date: "24/12/20", discipline: "SL", gates: 40, notes: "Ez", place: "Home", runs: 10, conditions: "Bad", uid: "skkkrt"))
    }
}


extension TrainingDetailsView{
    
    var noteView: some View{
        
        Text(skiDay.notes)
            .font(.system(size: 20))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .background(Color.darkerBlue)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)
            
    }
    

    var uploadVideoView: some View{
        
        
        Button {
            //Upload Video
        } label: {
            Text("Upload Video")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 220)
                .background(Color.darkerBlue)
                .cornerRadius(12)
                .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)
                
        }
    }
    var deleteButton: some View{
        Button {
            //
        } label: {
            Text("Delete")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .clipShape(Capsule())
                
        }
        .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
    }
    
}
