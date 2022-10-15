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

// struct FilteredDaysView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredDaysView(discipline: "SL")
//    }
// }
