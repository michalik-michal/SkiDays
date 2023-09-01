import SwiftUI
import AVKit

struct TrainingDetailsView: View {

    let skiDay: SkiDay

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = TrainingDetailsViewModel()
    @State private var showingConfirmation = false
    @State private var showVideo = false

    var body: some View {
        ScrollView(showsIndicators: false) {
            HStack {
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
            VStack(spacing: 15) {
                HStack {
                    DetailRowView(text: skiDay.discipline)
                    Spacer()
                    DetailRowView(text: skiDay.conditions)
                }
                if skiDay.discipline != "FREE" {
                    HStack {
                        DetailRowView(text: "\(skiDay.runs) runs")
                        DetailRowView(text: "\(skiDay.gates) gates")
                        DetailRowView(text: "\(skiDay.runs * skiDay.gates) total")
                    }
                    Rectangle()
                        .fill(Color.secondayBackground)
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(20)
                        .overlay {
                            CircularProgressView(progress: skiDay.consistency)
                        }
                } else {
                    DetailRowView(text: "\(skiDay.runs) runs")
                }
                if !skiDay.notes.isEmpty {
                    noteView
                }
                if !skiDay.video.isEmpty {
                    if let url = URL(string: skiDay.video) {
                        VStack(alignment: .trailing) {
                            Text("Full screen")
                                .bold()
                                .onTapGesture {
                                    showVideo.toggle()
                                }
                            VideoPlayer(player: AVPlayer(url: url))
                                .frame(height: 200)
                                .cornerRadius(20)
                        }
                    }
                }
                uploadVideoView
                    .hide(if: true)
                Spacer()
            }
        }
        .padding(.horizontal)
        .background(Color.background)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                deleteButton
            }
        }
        .sheet(isPresented: $showVideo) {
            if let url = URL(string: skiDay.video) {
                CustomVideoPlayer(url: url)
                    .frame(maxHeight: .infinity)
                    .background(.black)
            }
        }
    }
}

struct TrainingDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingDetailsView(skiDay: SkiDay(id: "1234",
                                           date: "24/12/20",
                                           discipline: "SL",
                                           gates: 40,
                                           notes: "Good day",
                                           place: "Home",
                                           runs: 10,
                                           consistency: 0.74,
                                           conditions: "Bad",
                                           slopeProfile: "",
                                           skis: "",
                                           video: ""))
    }
}

extension TrainingDetailsView {

    var deleteButton: some View {
        Button {
            showingConfirmation = true
        } label: {
            Image(systemName: "trash")
                .foregroundColor(.darkerBlue)
        }
        .alert(isPresented: $showingConfirmation) {
            Alert(
                title: Text("Are you sure?"),
                message: Text("Training will be deleted permanently."),
                primaryButton: .destructive(Text("Delete")) {
                    viewModel.deleteSkiDay(skiDay)
                    presentationMode.wrappedValue.dismiss()
                },
                secondaryButton: .cancel()
            )
        }
    }
    // MARK: - Notes View
    var noteView: some View {
        Text(skiDay.notes)
            .font(.system(size: 20))
            .foregroundColor(.blackWhite)
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .background(Color.secondayBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
    // MARK: - Upload Video
    var uploadVideoView: some View {
        Button {
            // Upload Video
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
