import SwiftUI
import Firebase

struct TrainingsListView: View {

    @ObservedObject var viewModel: TrainingListViewModel
    @ObservedObject var uploadSkiDayViewModel = AddTrainingViewModel()
    @State private var text: String = ""
    @State private var showMessage: Bool = false
    @State private var showAddTrainingView: Bool = false

    init(user: User) {
        self.viewModel = TrainingListViewModel(user: user)
    }

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 15) {
                    SearchBar(text: $viewModel.searchText)
                    ForEach(viewModel.searchableSkiDays) { skiDay in
                        TrainingRowView(skiDay: skiDay)
                    }
                    addTrainingWidget
                        .hide(if: viewModel.searchableSkiDays.count != 0)
                }
            }
            .onChange(of: viewModel.skiDays, perform: { _ in
                showMessage = true
            })
            .onTapGesture {
                self.endTextEditing()
            }
            .padding()
            .background(Color.background)
            .navigationTitle("Ski Days")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddTrainingView.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.blackWhite)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showAddTrainingView) {
            ModalNavigationView(showModal: $showAddTrainingView, content: AddTrainingView())
        }
        .overlay {
            MessageView(isVisible: $showMessage,
                        messageType: .succes,
                        message: "")
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
