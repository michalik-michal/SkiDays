import SwiftUI

struct StatsView: View {
    
    @ObservedObject var viewModel: StatsViewModel
    
    init(user: User){
        self.viewModel = StatsViewModel(user: user)
    }
    
    var body: some View {
        NavigationView {
            ScrollView{
                LazyVStack{
                    Circle()
                        .fill(.green)
                        .frame(width: 250, height: 250)
                        .padding(.bottom, 30)
                        .overlay {
                            Text("Add Chart")
                                .foregroundColor(.white)
                        }
                    VStack(spacing: 30){
                        ForEach(viewModel.stats){stat in
                            DisciplineStatsRow(stats: stat)
                        }
                    }
                }
                .navigationBarTitle("Statistics")
            }
            .padding()
            .background(Color.background)
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(user: User(id: "123", username: "meszkos", fullname: "meszkos", email: "meszkos", uid: "123"))
    }
}
