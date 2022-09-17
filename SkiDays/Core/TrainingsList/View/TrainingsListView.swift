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
                    addTrainingWidget
                        .hide(if: viewModel.searchableSkiDays.count != 0)
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
    private var addTrainingWidget: some View {
        NavigationLink {
            AddTrainingView()
        } label: {
            VStack {
                Image(systemName: "plus")
                    .font(.system(size: 40))
                    .padding(.bottom, 10)
                    .foregroundColor(.blue)
                Text("Add Training")
                    .font(.title2.bold())
                    .foregroundColor(.blackWhite)
            }
            .frame(height: 140)
            .frame(maxWidth: .infinity)
            .background(Color.secondayBackground)
            .cornerRadius(20)
        }
    }
}

struct TrainingsList_Previews: PreviewProvider {
    static var previews: some View {
        TrainingsListView(user: User(username: "1", fullname: "1", email: "1", uid: "1"))
    }
}
