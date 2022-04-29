//
//  TrainingDetailsView.swift
//  SkiDays
//
//  Created by MacOS on 29/04/2022.
//

import SwiftUI

struct TrainingDetailsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    
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
                    Text("19/12/22")
                        .font(.title)
                        .bold()
                        
                    Spacer()
                    Text("📍Obdach")
                        .font(.title)
                        .bold()
                }
                .padding(.top, 10)
                
                VStack(spacing: 30){
                    
                    HStack{
                        DetailRowView(text: "Giant Slalom")
                        
                        Spacer()
                        DetailRowView(text: "Icy")
                    }
                    HStack{
                        DetailRowView(text: "7 runs")
                        DetailRowView(text: "52 gates")
                        DetailRowView(text: "364 total")

                    }
                    noteView
                    uploadVideoView
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .padding(.horizontal)
    }
}

struct TrainingDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingDetailsView()
    }
}


extension TrainingDetailsView{
    
    var noteView: some View{
        
        Text("More over the foreline, better position bla bla bla bla")
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
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 220)
                .background(Color.darkerBlue)
                .cornerRadius(12)
                .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)
                
        }

        
    }
    
    
}
