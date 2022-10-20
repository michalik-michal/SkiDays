import SwiftUI

struct HomeView: View {

    @ObservedObject var viewModel: HomeViewModel
    @ObservedObject var statsViewModel: StatsViewModel

    init(user: User) {
        self.statsViewModel = StatsViewModel(user: user)
        self.viewModel = HomeViewModel(user: user)
    }

    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.skiDays.isEmpty {
                    VStack {
                        emptyView
                        addTrainingWidget
                    }
                } else {
                    VStack(spacing: 1) {
                        // headerView
                        buttonStack(model: viewModel)
                            .padding(.bottom)
                        AllStatsView(mainStats: statsViewModel.mainStats)
                    }
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
            .navigationTitle("Home")
            .onAppear {
                statsViewModel.getMainStats()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundColor(.darkerBlue)
                    }
                }
            }
        }
    }

    private var headerView: some View {
        VStack(spacing: -10) {
            Text("\(viewModel.skiDays.count)")
                .font(.system(size: 60).bold())
                .foregroundColor(viewModel.skiDays.count > 2 ? .black : .blackWhite)
            Text(viewModel.getTitle())
                .font(.system(size: 30)).bold()
                .foregroundColor(viewModel.skiDays.count > 2 ? .black : .blackWhite)
        }
        .frame(maxWidth: UIScreen.main.bounds.width)
        .frame(height: 200)
        .background(LinearGradient(gradient: Gradient(colors: viewModel.getColors()),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing))
        .cornerRadius(20)
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

    private var emptyView: some View {
        Image("emptyImage")
            .resizable()
            .frame(width: 200, height: 200)
            .frame(height: 400)
    }

    private var addTrainingWidget: some View {
        NavigationLink {
            AddTrainingView()
                .onDisappear {
                    statsViewModel.getStats()
                    statsViewModel.getMainStats()
                }
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
}
