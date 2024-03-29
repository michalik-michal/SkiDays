import SwiftUI

struct HomeView: View {

    @ObservedObject var viewModel: HomeViewModel
    @State private var showAddTrainingView: Bool = false
    @State private var showSettingsView: Bool = false

    init(user: User) {
        self.viewModel = HomeViewModel(user: user)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                switch viewModel.state {
                case .loading:
                    LoadingView()
                        .frame(width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.width)
                case .data:
                    if viewModel.skiDays.isEmpty {
                        VStack {
                            AstronautView()
                                .frame(width: 200, height: 400)
                            addTrainingWidget
                        }
                    } else {
                        VStack(spacing: 1) {
                            buttonStack(model: viewModel)
                                .padding(.bottom)
                            AllStatsView(mainStats: viewModel.mainStats)
                                .padding(.bottom)
                            lastNote
                        }
                    }
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
            .navigationTitle("Home")
            .onAppear {
                viewModel.getMainStats()
            }
            .fullScreenCover(isPresented: $showAddTrainingView) {
                ModalNavigationView(showModal: $showAddTrainingView, content: AddTrainingView())
            }
            .fullScreenCover(isPresented: $showSettingsView) {
                ModalNavigationView(showModal: $showSettingsView, content: SettingsView())
            }
            .onChange(of: showAddTrainingView, perform: { newValue in
                if newValue == false {
                    viewModel.getMainStats()
                }
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSettingsView.toggle()
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundColor(.blackWhite)
                    }
                }
            }
        }
    }

    private func buttonStack(model: HomeViewModel) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(StatsDisciplineFilter.allCases, id: \.rawValue) { item in
                    if model.numberOfDisciplineDays(item.title) != 0 {
                        DisciplineButtonView(discipline: item.title, days: model.numberOfDisciplineDays(item.title))
                    }
                }
            }
        }
    }

    private var addTrainingWidget: some View {
        Button {
            showAddTrainingView.toggle()
        } label: {
            VStack {
                Image(systemName: "plus")
                    .font(.system(size: 40))
                    .padding(.bottom, 10)
                    .foregroundColor(.blue)
                Text("Add First SkiDay")
                    .font(.title2.bold())
                    .foregroundColor(.blackWhite)
            }
            .frame(height: 140)
            .frame(maxWidth: .infinity)
            .background(Color.secondayBackground)
            .cornerRadius(20)
        }
    }

    private var lastNote: some View {
        VStack(alignment: .center) {
            HStack {
                Text("Last note")
                    .font(.title2).bold()
                Spacer()
            }
            .foregroundColor(.blackWhite)
            Divider()
            NavigationLink(viewModel.getLastSkiDayWithNote()?.notes ?? "",
                           value: viewModel.getLastSkiDayWithNote()?.notes ?? "")
                .font(.title3)
        }
        .navigationDestination(for: String.self) { _ in
            if let skiDay = viewModel.getLastSkiDayWithNote() {
                TrainingDetailsView(skiDay: skiDay)
                    .toolbar(.hidden, for: .tabBar)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.secondayBackground)
        .cornerRadius(20)
        .hide(if: viewModel.getLastSkiDayWithNote()?.notes ?? "" == "")
    }
}
