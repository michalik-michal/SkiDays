import SwiftUI
import AVKit

struct AddTrainingView: View {
    
    private enum Field { case place, conditions, runs }

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = UploadSkiDayViewModel()
    @FocusState private var focusedField: Field?
    
    @State private var date = Date()
    @State private var conditions: String = ""
    @State private var discipline: String = ""
    @State private var place: String = ""
    @State private var runs: String = ""
    @State private var gates: String = ""
    @State private var notes: String = ""
    @State private var isShowingVideoPicker: Bool = false
    @State private var runsFinished = 0.0
    @State private var video = UIImage()
    
    let buttons: [[DisciplineButtonViewModel]] = [
        [.SL, .GS, .SG ],
        [.DH, .FREE, .PARA]
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                // UGLY - find better solution
                HStack() {
                    Text(viewModel.provideTitle(discipline))
                        .font(.largeTitle).bold()
                    Spacer()
                }
                .overlay {
                    HStack {
                        Spacer()
                        DatePicker("", selection: $date, displayedComponents: .date)
                    }
                }
                .padding(.bottom, 20)
                VStack(alignment: .leading,spacing: 20) {
                    disciplineButtonsGrid
                    VStack(spacing: 40) {
                        CustomInputField(imageName: "mappin", placeholderText: "Place", text: $place)
                            .focused($focusedField, equals: .place)
                            .submitLabel(.next)
                        CustomInputField(imageName: "snowflake", placeholderText: "Conditions", text: $conditions)
                            .focused($focusedField, equals: .conditions)
                            .submitLabel(.next)
                        CustomInputField(imageName: "waveform.path.ecg", placeholderText: "Number of runs", text: $runs)
                            .focused($focusedField, equals: .runs)
                            .keyboardType(.numberPad)
                        CustomInputField(imageName: "italic", placeholderText: "Number of gates", text: $gates)
                            .keyboardType(.numberPad)
                    }
                    .padding(.top, 40)
                    .onSubmit {
                        manageSubmitActions()
                    }
                    if let runs = Double(runs) {
                        HStack {
                            Text("Runs finished: ")
                                .font(.title).bold()
                            Text(String(format: "%.0f", runsFinished))
                                .font(.title.bold())
                        }
                        Slider(value: $runsFinished, in: 0...runs, step: 1)
                    }
                    Text("Notes")
                        .font(.title).bold()
                    notesView
                    // Dont add video for now
                    //Text("Add video")
                    //  .font(.title).bold()
                    //addVideoView
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
            if succes {
                presentationMode.wrappedValue.dismiss()
            }
        })
        .padding()
        .background(Color.background)
        .foregroundColor(.blackWhite)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                doneButton
            }
        }
    }
    
    private func manageSubmitActions() {
        switch focusedField {
        case .place:
            focusedField = .conditions
        case .conditions:
            focusedField = .runs
        default:
            return
        }
    }
}

struct AddTrainingView_Previews: PreviewProvider {
    static var previews: some View {
        AddTrainingView()
    }
}

extension AddTrainingView {
    
    func fetchDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }
    
    var doneButton: some View {
            Button {
                viewModel.uploadSkiDay(date: fetchDate(date: date),
                                       discipline: discipline,
                                       place: place,
                                       conditions: conditions,
                                       runs: Int(runs) ?? 0,
                                       gates: Int(gates) ?? 0,
                                       consistency: (runsFinished / (Double(runs) ?? 0.0)),
                                       notes: notes,
                                       slopeProfile: "",
                                       skis: "",
                                       video: ""
                )
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Done")
                    .foregroundColor(.darkerBlue)
                    .font(.system(size: 20))
                    .padding(.top, 15)
                    .padding(.bottom, 5)
            }
    }
    
    var disciplineButtonsGrid: some View {
        ForEach(buttons, id: \.self){ row in
            HStack{
                ForEach(row, id: \.self){item in
                    Button {
                        discipline = item.rawValue
                    } label: {
                        Text(item.rawValue)
                            .foregroundColor(.blackWhite)
                            .font(.system(size: 20)).bold()
                    }
                    .frame(height: 60)
                    .frame(maxWidth: .infinity )
                    .background(Color.secondayBackground)
                    .cornerRadius(12)
                }
            }
        }
    }
    var notesView: some View {
        TextEditor(text: $notes)
            .frame(height: 200)
//            .background(RoundedRectangle(cornerRadius: 20)
//                .stroke(.gray.opacity(0.2), lineWidth: 2)
//                .background(Color.secondayBackground))
            .cornerRadius(20)
    }
//    var addVideoView: some View {
//        Image(systemName: "plus")
//            .foregroundColor(.darkerBlue)
//            .frame(height: 200)
//            .frame(maxWidth: .infinity)
//            .font(.system(size: 40))
//            .overlay(RoundedRectangle(cornerRadius: 16)
//                .stroke(.gray.opacity(0.2), lineWidth: 2)
//                .background(Color.secondayBackground))
//            .onTapGesture {
//                isShowingVideoPicker.toggle()
//            }
//    }
}

