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
    @StateObject var imagePicker = ImagePickerViewModel()
    
    @State private var date = Date()
    @State private var conditions: String = ""
    @State private var discipline: String = ""
    @State private var place: String = ""
    @State private var runs: String = ""
    @State private var gates: String = ""
    @State private var notes: String = ""
    
    @State private var isShowingVideoPicker: Bool = false
    
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
                    
                    Image(systemName: "plus")
                        .foregroundColor(.darkerBlue)
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 40))
                        .overlay(RoundedRectangle(cornerRadius: 16)
                                    .stroke(.gray.opacity(0.2), lineWidth: 2))
                        .onTapGesture {
                            imagePicker.openImagePicker()
                        }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10){
                           
                            
                            ForEach(imagePicker.fetchedPhotos){photo in
                                ThumbnailView(photo: photo)
                                    .onTapGesture {
                                        imagePicker.extractPreviewData(asset: photo.asset)
                                        imagePicker.showPreview.toggle()
                                    }
                            }
                            
                            if imagePicker.libraryStatus == .denied || imagePicker.libraryStatus == .limited{
                                VStack(spacing: 10){
                                    Text(imagePicker.libraryStatus == .denied ? "Allow Acces For Videos" : "Select More Videos")
                                        .foregroundColor(.gray)
                                    Button(action: {
                                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!,options: [:],
                                        completionHandler: nil)
                                    }) {
                                        Text(imagePicker.libraryStatus == .denied ? "Allow Acces" : "Select More")
                                            .foregroundColor(.white)
                                            .fontWeight(.bold)
                                            .padding(.vertical, 10)
                                            .padding(.horizontal)
                                            .background(Color.blue)
                                            .cornerRadius(5)
                                    }
                                }
                                .frame(height: 150)
                            }
                        }
                        .padding()
                    }
                    .frame(height: imagePicker.showImagePicker ? 200 : 0)
                    .background(Color.primary.opacity(0.04))
                    .opacity(imagePicker.showImagePicker ? 1 : 0)
                }
            }
        }
        .onAppear(perform: imagePicker.setUp)
        .sheet(isPresented: $imagePicker.showPreview, onDismiss: {
            imagePicker.selectedVideoPreview = nil
            imagePicker.selectedImagePreview = nil
        },content: {
            PreviewView()
                .environmentObject(imagePicker)
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
            dateFormatter.dateFormat = "MM/dd/yy"
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
}

struct ThumbnailView: View{
    
    var photo: Asset
    
    var body: some View{
        
        ZStack(alignment: .bottomTrailing) {
            Image(uiImage: photo.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .cornerRadius(10)
            
            if photo.asset.mediaType == .video{
                Image(systemName: "vido.fill")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(8)
            }
        }
        
    }
}

struct PreviewView: View{
    
    @EnvironmentObject var imagePicekr: ImagePickerViewModel
    
    var body: some View{
        NavigationView{
            ZStack{
                
                if imagePicekr.selectedVideoPreview != nil{
                    VideoPlayer(player: AVPlayer(playerItem: AVPlayerItem(asset: imagePicekr.selectedVideoPreview)))
                }
                
                if imagePicekr.selectedImagePreview != nil{
                    
                    Image(uiImage: imagePicekr.selectedImagePreview)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Text("Add")
                    }
                }
            }
        }
    }
    
}

