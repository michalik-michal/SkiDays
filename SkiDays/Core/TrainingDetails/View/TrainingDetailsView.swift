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
    @ObservedObject var viewModel = TrainingDetailsViewModel()
    @State private var showingConfirmation = false
    
    var body: some View {
            ScrollView{
                buttonStack
                HStack{
                    Text(skiDay.date)
                        .font(.title)
                        .bold()
                        .foregroundColor(.blackWhite)
                    Spacer()
                    Text("📍\(skiDay.place)")
                        .font(.title)
                        .bold()
                        .foregroundColor(.blackWhite)
                }
                .padding(.top, 10)
                VStack(spacing: 30){
                    HStack{
                        DetailRowView(text: skiDay.discipline)
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
                    
                    Spacer()
                }
            }
            .padding(.horizontal)
            .background(Color.background)
            .navigationBarHidden(true)
    }
}

struct TrainingDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingDetailsView(skiDay: SkiDay(id: "1234", date: "24/12/20", discipline: "SL", gates: 40, notes: "Good day", place: "Home", runs: 10, conditions: "Bad", uid: "skkkrt"))
    }
}


extension TrainingDetailsView{
    
//MARK: - Button Stack
    var buttonStack: some View{
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
            Button {
                showingConfirmation = true
                
            } label: {
                Image(systemName: "trash")
                    .foregroundColor(.red)
                    .font(.system(size: 25))
                    .frame(width: 30, height: 30)
                    .padding(.top, 30)
                    .padding(.bottom, 5)
            }
            .alert(isPresented: $showingConfirmation){
                Alert(
                    title: Text("Are you sure?"),
                    message: Text("Training will be deleted permanently."),
                    primaryButton: .destructive(Text("Delete")){
                        viewModel.deleteSkiDay(skiDay)
                        presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }

//MARK: - Notes View
    var noteView: some View{
        Text(skiDay.notes)
            .font(.system(size: 20))
            .foregroundColor(.blackWhite)
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .background(Color.secondayBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            
    }
    
//MARK: - Upload Video
    var uploadVideoView: some View{
        
        Button {
            //Upload Video
        } label: {
            Text("Upload Video")
                .font(.headline)
                .foregroundColor(.blackWhite)
                .frame(maxWidth: .infinity)
                .frame(height: 220)
                .background(Color.secondayBackground)
                .cornerRadius(12)                
        }
    }
    

    
}
