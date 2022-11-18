import SwiftUI

struct DisciplineStatsRow: View {

    var stats: DisciplineStats
    var user: User

    var body: some View {
        NavigationStack {
            VStack {
                headerStack
                Divider()
                HStack {
                    Text("Most skied conditions: ")
                        .font(.title3)
                    Text("\(stats.mostSkiedContidions)")
                        .font(.title2.bold())
                    Spacer()
                }
                if stats.discipline == "FREE" {
                    HStack {
                        Text("\(stats.totalRuns)")
                            .font(.title2.bold())
                        Text("runs")
                            .font(.title2)
                        Spacer()
                    }
                } else {
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
                            }
                            Spacer()
                            CircularProgressView(progress: stats.consistency)
                                .padding(.trailing, 20)
                        }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.secondayBackground)
            .cornerRadius(20)
        }
    }

    private var headerStack: some View {
        HStack {
            NavigationLink(stats.discipline, value: stats.discipline)
                .font(.largeTitle.bold())
            Spacer()
            Text("\(stats.numberOfDays)")
                .font(.title).bold()
            Text("\(getDayTitle())")
                .font(.title2)
        }
        .navigationDestination(for: String.self) { discipline in
            FilteredDaysView(user: user, discipline: discipline)
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
    static let user = User(username: "", fullname: "", email: "", uid: "")
    static var previews: some View {
        DisciplineStatsRow(stats: DisciplineStats(discipline: "SL",
                                                  numberOfDays: 10,
                                                  totalRuns: 100,
                                                  totalGates: 960,
                                                  averageRuns: 10,
                                                  averageGates: 30,
                                                  consistency: 0.54,
                                                  mostSkiedContidions: "Soft"),
                           user: user
        )
    }
}
