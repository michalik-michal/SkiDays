import SwiftUI
import AVKit

struct AddTrainingView: View {

    private enum Field { case place, runs }

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = UploadSkiDayViewModel()
    @FocusState private var focusedField: Field?

    @State private var shouldShowMessage = false
    @State private var date = Date()
    @State private var conditions: String = "Snow"
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
                HStack {
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
                VStack(alignment: .leading, spacing: 20) {
                    disciplineButtonsGrid
                        .padding(.horizontal, 1)
                    VStack(spacing: 40) {
                        CustomInputField(imageName: "mappin", placeholderText: "Place", text: $place)
                            .focused($focusedField, equals: .place)
                            .submitLabel(.next)

                        CustomInputField(imageName: "waveform.path.ecg", placeholderText: "Number of runs", text: $runs)
                            .focused($focusedField, equals: .runs)
                            .keyboardType(.numberPad)
                        CustomInputField(imageName: "italic", placeholderText: "Number of gates", text: $gates)
                            .keyboardType(.numberPad)
                        menu

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
                    // Don't add video for now
                    // Text("Add video")
                    //  .font(.title).bold()
                    // addVideoView
                }
            }
        }
        .fullScreenCover(isPresented: $isShowingVideoPicker, content: {
            VideoPicker(video: $video)
        })
        .overlay {
            MessageView(messageType: .error,
                        message: "Please select discipline",
                        isVisible: $shouldShowMessage)
        }
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
            focusedField = .runs
        default:
            return
        }
    }
    private var menu: some View {
        Menu {
            Button {
                conditions = "-"
            } label: {
                Text("-")
            }
            Button {
                conditions = "Soft"
            } label: {
                Text("Soft")
            }
            Button {
                conditions = "Grippy"
            } label: {
                Text("Grippy")
            }
            Button {
                conditions = "Bumpy"
            } label: {
                Text("Bumpy")
            }
            Button {
                conditions = "Hard"
            } label: {
                Text("Hard")
            }
            Button {
                conditions = "Compact"
            } label: {
                Text("Compact")
            }
            Button {
                conditions = "Ice"
            } label: {
                Text("Ice")
            }
            Button {
                conditions = "Rats"
            } label: {
                Text("Rats")
            }
            Button {
                conditions = "Salt"
            } label: {
                Text("Salt")
            }
        } label: {
            HStack {
                Image(systemName: "snowflake")
                Text(conditions)
                Spacer()
            }
            .padding(.leading)
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.secondayBackground)
            .cornerRadius(12)
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
                if discipline != "" {
                    let skiDay = SkiDay(date: fetchDate(date: date),
                                        discipline: discipline,
                                        gates: Int(gates) ?? 0,
                                        notes: notes,
                                        place: place,
                                        runs: Int(runs) ?? 0,
                                        consistency: (runsFinished / (Double(runs) ?? 1.0)),
                                        conditions: conditions,
                                        slopeProfile: "",
                                        skis: "",
                                        video: "")
                    viewModel.uploadSkiDay(skiDay: skiDay
                    )
                    presentationMode.wrappedValue.dismiss()
                } else {
                    shouldShowMessage = true
                }
            } label: {
                Text("Done")
                    .foregroundColor(.darkerBlue)
                    .font(.system(size: 20))
                    .padding(.top, 15)
                    .padding(.bottom, 5)
            }
    }

    var disciplineButtonsGrid: some View {
        ForEach(buttons, id: \.self) { row in
            HStack {
                ForEach(row, id: \.self) { item in
                    Text(item.rawValue)
                        .foregroundColor(.blackWhite)
                        .font(.system(size: 20)).bold()
                        .frame(height: 60)
                        .frame(maxWidth: .infinity )
                        .background(Color.secondayBackground)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(item.rawValue == discipline ? .blue : .secondayBackground, lineWidth: 2))
                        .onTapGesture {
                            discipline = item.rawValue
                        }
                }
            }
        }
    }
    var notesView: some View {
        TextEditor(text: $notes)
            .frame(height: 200)
            .scrollContentBackground(.hidden)
            .background(Color.secondayBackground)
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
