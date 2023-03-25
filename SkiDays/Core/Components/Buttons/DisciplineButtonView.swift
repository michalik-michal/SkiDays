import SwiftUI

struct DisciplineButtonView: View {

    @ObservedObject var viewModel = AuthViewModel()
    var discipline: String
    var days: Int

    var body: some View {
        NavigationLink {
            if let user = viewModel.currentUser {
                FilteredDaysView(user: user, discipline: discipline)
            }
        } label: {
            Circle()
                .frame(width: 60, height: 60)
                .foregroundColor(.secondayBackground)
                .overlay {
                    VStack(alignment: .center) {
                        Text("\(days)")
                            .font(.title2).bold()
                            .foregroundColor(.blackWhite)
                        Text(discipline)
                            .foregroundColor(.blackWhite)
                            .font(.footnote)
                    }
                }
        }
    }
}

struct DisciplineButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DisciplineButtonView(discipline: "SL", days: 12)
    }
}
