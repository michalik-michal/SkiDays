import SwiftUI

struct TrainingDetailsView: View {

    let skiDay: SkiDay

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = TrainingDetailsViewModel()
    @State private var showingConfirmation = false

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
                noteView
                    .hide(if: skiDay.notes == "")
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
                .foregroundColor(.red)
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
