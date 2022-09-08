import SwiftUI

struct DisciplineStatsRow: View {
    
    var stats: DisciplineStats
    
    var body: some View {
        VStack(spacing: 10){
            HStack{
                Text(stats.discipline)
                    .font(.largeTitle).bold()
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
            HStack{
                VStack(alignment: .leading,spacing: 10){
                    Text("Total runs: \(stats.totalRuns)")
                        .font(.system(size: 20))
                    Text("Total gates: \(stats.totalGates)")
                        .font(.system(size: 20))
                }
                Spacer()
                VStack(alignment: .leading,spacing: 10){
                    Text("Average: \(stats.averageRuns)")
                        .font(.system(size: 20))
                    Text("Average: \(stats.averageGates)")
                        .font(.system(size: 20))
                }
            }
            .padding()
        }
        .background(Color.secondayBackground)
        .foregroundColor(.blackWhite)
        .cornerRadius(20)
    }
}

struct DisciplineStatsRow_Previews: PreviewProvider {
    static var previews: some View {
        DisciplineStatsRow(stats: DisciplineStats(discipline: "SL", numberOfDays: 10, totalRuns: 100, totalGates: 10000, averageRuns: 10, averageGates: 30))
    }
}
