import SwiftUI

struct AllStatsView: View {
    
    var mainStats: MainStats
    
    var body: some View {
        VStack() {
            headerStack
            Divider()
            disciplineSection
            HStack {
                Text("Most skied conditions: ")
                    .font(.title3)
                Text(mainStats.mostSkiedContidions ?? "-")
                    .font(.title2.bold())
                Spacer()
            }
            Divider()
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(mainStats.totalGates ?? 0)")
                            .font(.title2.bold())
                        Text("gates")
                            .font(.title2)
                    }
                    HStack {
                        Text("\(mainStats.totalRuns ?? 0)")
                            .font(.title2.bold())
                        Text("runs")
                            .font(.title2)
                    }
                }
                Spacer()
                CircularProgressView(progress: mainStats.consistency ?? 0)
                    .padding(.trailing, 20)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.secondayBackground)
        .cornerRadius(20)
    }
    
    private var headerStack: some View {
        HStack {
            Text("ALL")
                .font(.largeTitle.bold())
            Spacer()
            Text("\(mainStats.numberOfDays ?? 0)")
                .font(.title).bold()
            Text("DAYS")
                .font(.title2)
        }
        .padding(.bottom)
    }
    
    private var disciplineSection: some View {
        HStack {
            Text("Most skied: ")
                .font(.title3)
            Text("\(mainStats.mostSkiedDiscipline ?? "")")
                .font(.title2).bold()
            Spacer()
            Text("\(mainStats.mostSkiedDisciplineDays ?? 0)")
                .font(.title2).bold()
            Text("DAYS")
                .font(.title3)
        }
        .padding(.bottom, 5)
    }
}

struct AllStatsView_Previews: PreviewProvider {
    static var previews: some View {
        AllStatsView(mainStats: MainStats(numberOfDays: 1, mostSkiedDiscipline: "SL", mostSkiedDisciplineDays: 1, mostSkiedContidions: "Soft", totalGates: 10, totalRuns: 10, consistency: 0.5))
    }
}
