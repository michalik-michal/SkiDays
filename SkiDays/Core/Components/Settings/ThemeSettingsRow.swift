import SwiftUI

struct ThemeSettingsRow: View {

    @State var selectedIndex = 0
    @Namespace private var animation
    @ObservedObject var model = SettingsViewModel()
    private let impactMedium = UIImpactFeedbackGenerator(style: .medium)

    var body: some View {
        SettingsRow(image: "lightbulb", title: "Theme")
            .overlay {
                HStack {
                    Spacer()
                    HStack(spacing: 5) {
                        themeButtom(image: "sun.max", tag: 0, animation: animation)
                        themeButtom(image: "moon", tag: 1, animation: animation)
                        themeButtom(image: "iphone", tag: 2, animation: animation)
                    }
                    .padding(.horizontal)
                    .foregroundColor(.blackWhite)
                    .frame(height: 50)
                    .background(Color.secondayBackground)
                    .cornerRadius(20)

                }
                .onAppear { selectedIndex = model.getSelectedMode() }
                .padding(.trailing)
            }
    }
    private func themeButtom(image: String, tag: Int, animation: Namespace.ID) -> some View {
        ZStack {
            if selectedIndex == tag {
                Rectangle()
                    .fill(Color.background)
                    .frame(width: 30, height: 30)
                    .cornerRadius(90)
                    .matchedGeometryEffect(id: "underline_animation", in: animation)
            }
                Image(systemName: image)
                    .font(selectedIndex == tag ? Font.body.weight(.bold) : Font.body.weight(.regular))
                    .padding(10)
                    .onTapGesture {
                        selectedIndex = tag
                        impactMedium.impactOccurred()
                        model.setAppTheme(tag: tag)
                    }
        }
    }
}

struct ThemeSettingsRow_Previews: PreviewProvider {
    static var previews: some View {
        ThemeSettingsRow()
    }
}
