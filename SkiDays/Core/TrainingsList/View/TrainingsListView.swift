import SwiftUI
import Firebase

struct TrainingsListView: View {
    
    @ObservedObject var viewModel: TrainingListViewModel
    @State var text: String = ""
    
    init(user: User) {
        self.viewModel = TrainingListViewModel(user: user)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 15) {
                HStack {
                    Text("Ski Days")
                        .font(.largeTitle).bold()
                        .foregroundColor(.blackWhite)
                    Spacer()
                    NavigationLink{
                        AddTrainingView()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.darkerBlue)
                            .font(.system(size: 25))
                            .frame(width: 30, height: 30)
                    }
                }
                .padding(.top, 30)
                SearchBar(text: $viewModel.searchText)
                ForEach(viewModel.searchableSkiDays){skiDay in
                    TrainingRowView(skiDay: skiDay)
                }
            }
        }
        .onTapGesture {
            self.endTextEditing()
        }
        .padding()
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .background(Color.background)
    }
}

struct TrainingsList_Previews: PreviewProvider {
    static var previews: some View {
        TrainingsListView(user: User(username: "1", fullname: "1", email: "1", uid: "1"))
    }
}
