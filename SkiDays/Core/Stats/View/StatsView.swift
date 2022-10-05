import SwiftUI
import Charts

struct StatsView: View {
    
    @ObservedObject var viewModel: StatsViewModel
    @Namespace var animation
    
    @State private var selectedDiscipline: StatsDisciplineFilter = .all
    
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
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(StatsDisciplineFilter.allCases, id: \.rawValue) { item in
                                VStack {
                                    Text(item.title)
                                        .font(.subheadline)
                                        .fontWeight(selectedDiscipline == item ? .bold : .regular)
                                        .frame(width: 50)
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
                        
                    }
                    .overlay {
                        Divider()
                            .offset(y: 16)
                    }
                    if selectedDiscipline == .all {
                        AllStatsView(mainStats: viewModel.mainStats)
                    } else {
                        DisciplineStatsRow(stats: viewModel.getStatsFor(selectedDiscipline.title))
                    }
                    
                }
                .navigationBarTitle("Statistics")
            }
            .onAppear {
                viewModel.getStats()
                viewModel.getMainStats()
            }
            .padding()
            .background(Color.background)
        }
    }
    
    private var chartView: some View {
        Chart(viewModel.disciplineStats) { stat in
            BarMark(x: .value("Discipline", stat.discipline),
                    y: .value("Days", stat.animate ? stat.numberOfDays : 0))
            .foregroundStyle(viewModel.gradient)
        }
        .chartLegend(.hidden)
        .frame(height: 200)
        .padding(.top)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                for (index,_) in viewModel.disciplineStats.enumerated() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.05) {
                        withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.8)) {
                            viewModel.disciplineStats[index].animate = true
                        }
                    }
                }
            }
        }
        
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
