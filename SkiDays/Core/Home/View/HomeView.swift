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
    private var totalLabel: some View {
        Text("Total: \(viewModel.skiDays.count)")
            .font(.system(size: 60))
            .foregroundColor(.blackWhite)
            .frame(width: 300, height: 160)
            .background(Color.secondayBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .padding(.top, 20)
            .padding(.bottom, 60)
    }
    
    private var circleView: some View {
        Circle()
            .strokeBorder(
                AngularGradient(gradient: Gradient(colors: viewModel.getColors()), center: .center, startAngle: .zero, endAngle: .degrees(360)),
                lineWidth: 30)
            .frame(width: 220, height: 220)
            .padding(.vertical, 10)
            .foregroundColor(.buttonColor)
            .offset(y: -20)
            .overlay {
                VStack(spacing: -10) {
                    Text("\(viewModel.skiDays.count)")
                        .font(.system(size: 60).bold())
                    Text(viewModel.getTitle())
                        .font(.system(size: 30))
                }
                .offset(y: -20)
            }
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


