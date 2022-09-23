import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    init(user: User) {
        self.viewModel = HomeViewModel(user: user)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                circleView
                buttonStack(model: viewModel)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
            .navigationTitle("Home")
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
    
    private var circleView: some View {
        VStack(spacing: -10) {
            Text("\(viewModel.skiDays.count)")
                .font(.system(size: 60).bold())
                .foregroundColor(viewModel.skiDays.count > 2 ? .white : .blackWhite)
            Text(viewModel.getTitle())
                .font(.system(size: 30))
                .foregroundColor(viewModel.skiDays.count > 2 ? .white : .blackWhite)
        }
        .frame(maxWidth: UIScreen.main.bounds.width)
        .frame(height: 200)
        .background(LinearGradient(gradient: Gradient(colors: viewModel.getColors()),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing))
        .cornerRadius(20)
        .offset(y: -30)
    }
    
    private func buttonStack(model: HomeViewModel) -> some View {
        VStack(spacing: 20){
            HStack(spacing: 10){
                DisciplineButtonView(discipline: "SL", days: model.numberOfDisciplineDays("SL"))
                DisciplineButtonView(discipline: "GS", days: model.numberOfDisciplineDays("GS"))
            }
            HStack(spacing: 10){
                DisciplineButtonView(discipline: "SG", days: model.numberOfDisciplineDays("SG"))
                DisciplineButtonView(discipline: "DH", days: model.numberOfDisciplineDays("DH"))
            }
            HStack(spacing: 10){
                DisciplineButtonView(discipline: "FREE", days: model.numberOfDisciplineDays("FREE"))
                DisciplineButtonView(discipline: "PARA", days: model.numberOfDisciplineDays("PARA"))
            }
        }
    }
}


