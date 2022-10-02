import SwiftUI

struct DisciplineStatsRow: View {
    
    var stats: DisciplineStats
    
    var body: some View {
        VStack() {
            headerStack
            Divider()
            HStack {
                Text("Most skied conditions: ")
                    .font(.title3)
                Text("Soft")
                    .font(.title2.bold())
                Spacer()
            }
            Divider()
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(stats.totalGates)")
                            .font(.title2.bold())
                        Text("gates")
                            .font(.title2)
                    }
                    HStack {
                        Text("\(stats.totalRuns)")
                            .font(.title2.bold())
                        Text("runs")
                            .font(.title2)
                    }
                    HStack {
                        Text("65")
                            .font(.title2.bold())
                        Text("finished")
                            .font(.title2)
                    }
                }
                Spacer()
                CircularProgressView(progress: 0.54)
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
            Text(stats.discipline)
                .font(.largeTitle.bold())
            Spacer()
            Text("\(stats.numberOfDays)")
                .font(.title).bold()
            Text("\(getDayTitle())")
                .font(.title2)
        }
        .padding(.bottom)
    }
    private func getDayTitle() -> String {
        switch stats.numberOfDays {
        case 1:
            return "DAY"
        default:
            return "DAYS"
        }
    }
}

struct DisciplineStatsRow_Previews: PreviewProvider {
    static var previews: some View {
        DisciplineStatsRow(stats: DisciplineStats(discipline: "SL", numberOfDays: 10, totalRuns: 100, totalGates: 960, averageRuns: 10, averageGates: 30))
    }
}
