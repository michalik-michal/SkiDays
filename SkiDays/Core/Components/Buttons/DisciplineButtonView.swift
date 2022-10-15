import SwiftUI

struct DisciplineButtonView: View {

    var discipline: String
    var days: Int
    @ObservedObject var viewModel = AuthViewModel()

    var body: some View {
        NavigationLink {
            if let user = viewModel.currentUser {
                FilteredDaysView(user: user, discipline: discipline)
            }
        } label: {
            Text("\(discipline): \(days)")
                .foregroundColor(.blackWhite)
                .font(.system(size: 35)).bold()
        }
        .frame(height: 80)
        .frame(maxWidth: .infinity)
        .background(Color.secondayBackground)
        .cornerRadius(12)
    }
}

struct DisciplineButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DisciplineButtonView(discipline: "SL", days: 12)
    }
}
