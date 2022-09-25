import SwiftUI
import Charts

struct StatsView: View {
    
    @ObservedObject var viewModel: StatsViewModel
    @Namespace var animation
    
    @State private var selectedDiscipline: StatsDisciplineFilter = .sl
    
    init(user: User){
        self.viewModel = StatsViewModel(user: user)
    }
    let chartColors: [Color] = [.pastelGreen, .pastelBlue, .pastelYellow, .pastelOrange, .pastelPurple, .pastelRed]
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    if viewModel.skiDays.count < 2 {
                        emptyView
                    } else {
                        chartView
                    }
                    HStack {
                        ForEach(StatsDisciplineFilter.allCases, id: \.rawValue) { item in
                            VStack {
                                Text(item.title)
                                    .font(.subheadline)
                                    .fontWeight(selectedDiscipline == item ? .bold : .regular)
                                if selectedDiscipline == item {
                                    Capsule()
                                        .foregroundColor(viewModel.getCapsuleColor(for: item.title))
                                        .frame(height: 3)
                                        .matchedGeometryEffect(id: "filter", in: animation)
                                } else {
                                    Capsule()
                                        .foregroundColor(.clear)
                                        .frame(height: 3)
                                }
                            }
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    self.selectedDiscipline = item
                                }
                            }
                        }
                    }
                    .overlay {
                        Divider()
                            .offset(y: 16)
                    }
                    DisciplineStatsRow(stats: viewModel.getStatsFor(selectedDiscipline.title))
                    
                }
                .navigationBarTitle("Statistics")
            }
            .onAppear {
                viewModel.getStats()
            }
            .padding()
            .background(Color.background)
        }
    }
    
    private var chartView: some View {
        Chart(viewModel.stats) { stat in
            BarMark(x: .value("Discipline", stat.discipline),
                    y: .value("Days", stat.numberOfDays))
            .foregroundStyle(viewModel.gradient)
        }
        .chartLegend(.hidden)
        .frame(height: 200)
        .padding(.top)
    }
    
    private var emptyView: some View {
        VStack() {
            Image("emptyImage")
                .resizable()
                .frame(width: 150, height: 150)
            Text("Add more data...")
                .font(.title2.bold())
        }
        .frame(height: 250)
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(user: User(id: "123", username: "meszkos", fullname: "meszkos", email: "meszkos", uid: "123"))
    }
}
