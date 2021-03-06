//
//  AddTrainingView.swift
//  SkiDays
//
//  Created by MacOS on 29/04/2022.


import SwiftUI
import AVKit

struct AddTrainingView: View {

    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = UploadSkiDayViewModel()

    
    @State private var date = Date()
    @State private var conditions: String = ""
    @State private var discipline: String = ""
    @State private var place: String = ""
    @State private var runs: String = ""
    @State private var gates: String = ""
    @State private var notes: String = ""
    @State private var isShowingVideoPicker: Bool = false
    @State private var video = UIImage()
    
    let buttons: [[DisciplineButtonViewModel]] = [
        [.SL, .GS, .SG ],
        [.DH, .FREE, .PARA]
    ]
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    backButton
                    Spacer()
                    doneButton
                }
                HStack{
                    Text(viewModel.provideTitle(discipline))
                        .font(.largeTitle).bold()
                    Spacer()
                }
                DatePicker("", selection: $date, displayedComponents: .date)
                    
                    .padding(.bottom, 20)
                VStack(alignment: .leading,spacing: 20){
                    
                    disciplineButtonsGrid

                    VStack(spacing: 40){
                        CustomInputField(imageName: "mappin", placeholderText: "Place", text: $place)
                        CustomInputField(imageName: "snowflake", placeholderText: "Conditions", text: $conditions)
                        CustomInputField(imageName: "waveform.path.ecg", placeholderText: "Number of runs", text: $runs)
                            .keyboardType(.numberPad)
                        CustomInputField(imageName: "italic", placeholderText: "Number of gates", text: $gates)
                            .keyboardType(.numberPad)
                    }
                    .padding(.top, 40)
                    
                    Text("Enter your notes")
                        .font(.title).bold()
                    
                    notesView
                    Text("Add video")
                        .font(.title).bold()
                    
                    addVideoView
                    
                        
                }
            }
        }
        .fullScreenCover(isPresented: $isShowingVideoPicker, content: {
            VideoPicker(video: $video)
        })
        .onTapGesture {
            self.endTextEditing()
        }
        .onReceive(viewModel.$didUploadSkiDay, perform: { succes in
            if succes{
                presentationMode.wrappedValue.dismiss()
            }
        })
        .navigationBarHidden(true)
        .padding()
    }
}

struct AddTrainingView_Previews: PreviewProvider {
    static var previews: some View {
        AddTrainingView()
    }
}

extension AddTrainingView{
    
    func fetchDate(date: Date) -> String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yy"
            let stringDate = dateFormatter.string(from: date)
            return stringDate
    }
    
     var doneButton: some View{
         Button {
             viewModel.uploadSkiDay(date: fetchDate(date: date),
                                    discipline: discipline,
                                    place: place,
                                    conditions: conditions,
                                    runs: Int(runs) ?? 0,
                                    gates: Int(gates) ?? 0,
                                    notes: notes)
             presentationMode.wrappedValue.dismiss()
             
         } label: {
             Text("Done")
                 .foregroundColor(.darkerBlue)
                 .font(.system(size: 20))
                 .padding(.top, 15)
                 .padding(.bottom, 5)
         }
    }
    
    var backButton: some View{
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

    var disciplineButtonsGrid: some View{
        ForEach(buttons, id: \.self){ row in
            HStack{
                ForEach(row, id: \.self){item in
                    Button {
                        discipline = item.rawValue
                    } label: {
                        Text(item.rawValue)
                            .foregroundColor(.white)
                            .font(.system(size: 20)).bold()
                    }
                    .frame(height: 60)
                    .frame(maxWidth: .infinity )
                    .background(Color.darkerBlue)
                    .cornerRadius(12)
                    .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)

                }
            }
        }
    }
    
    var notesView: some View{
        
        TextEditor(text: $notes)
            .frame(height: 200)
            .overlay(RoundedRectangle(cornerRadius: 16)
                        .stroke(.gray.opacity(0.2), lineWidth: 2))
        
    }
    
    var addVideoView: some View{
        Image(systemName: "plus")
            .foregroundColor(.darkerBlue)
            .frame(height: 200)
            .frame(maxWidth: .infinity)
            .font(.system(size: 40))
            .overlay(RoundedRectangle(cornerRadius: 16)
                        .stroke(.gray.opacity(0.2), lineWidth: 2))
            .onTapGesture {
                isShowingVideoPicker.toggle()
            }
    }
}

