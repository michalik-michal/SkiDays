import SwiftUI

struct AllStatsView: View {
    var body: some View {
        VStack() {
            headerStack
            Divider()
            disciplineSection
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
                        Text("1242")
                            .font(.title2.bold())
                        Text("gates")
                            .font(.title2)
                    }
                    HStack {
                        Text("180")
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
            Text("ALL")
                .font(.largeTitle.bold())
            Spacer()
            Text("49")
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
            Text("SL")
                .font(.title2).bold()
            Spacer()
            Text("44")
                .font(.title2).bold()
            Text("DAYS")
                .font(.title3)
        }
        .padding(.bottom)
    }
}

struct AllStatsView_Previews: PreviewProvider {
    static var previews: some View {
        AllStatsView()
    }
}
