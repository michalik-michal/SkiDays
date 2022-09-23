import SwiftUI

struct StatsView: View {
    
    @ObservedObject var viewModel: StatsViewModel
    @Namespace var animation
    
    @State private var selectedDiscipline: StatsDisciplineFilter = .sl
    
    init(user: User){
        self.viewModel = StatsViewModel(user: user)
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVStack{
                    Circle()
                        .fill(.green)
                        .frame(width: 250, height: 250)
                        .padding(.bottom, 30)
                        .overlay {
                            Text("Add Chart")
                                .foregroundColor(.white)
                        }
                    HStack {
                        ForEach(StatsDisciplineFilter.allCases, id: \.rawValue) { item in
                            VStack {
                                Text(item.title)
                                    .font(.subheadline)
                                    .fontWeight(selectedDiscipline == item ? .bold : .regular)
                                if selectedDiscipline == item {
                                    Capsule()
                                        .foregroundColor(.blue)
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
