import SwiftUI
import Firebase

struct TrainingsListView: View {
    
    @ObservedObject var viewModel: TrainingListViewModel
    @State var text: String = ""
    
    init(user: User) {
        self.viewModel = TrainingListViewModel(user: user)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 15) {
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
            .background(Color.background)
            .navigationTitle("Ski Days")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink{
                        AddTrainingView()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.darkerBlue)
                    }
                }
            }
        }
    }
}

struct TrainingsList_Previews: PreviewProvider {
    static var previews: some View {
        TrainingsListView(user: User(username: "1", fullname: "1", email: "1", uid: "1"))
    }
}
