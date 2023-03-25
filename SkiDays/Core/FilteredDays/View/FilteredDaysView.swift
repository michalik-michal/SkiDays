import SwiftUI

struct FilteredDaysView: View {

    @ObservedObject var viewModel: FilteredDaysViewModel

    init(user: User, discipline: String) {
        self.viewModel = FilteredDaysViewModel(user: user, discipline: discipline)
    }

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 15) {
                ForEach(viewModel.skiDays) {skiDay in
                    if skiDay.discipline.contains(viewModel.discipline) {
                        TrainingRowView(skiDay: skiDay)
                    }
                }
            }
        }
        .padding()
        .navigationTitle(viewModel.title)
        .background(Color.background)
    }
}
