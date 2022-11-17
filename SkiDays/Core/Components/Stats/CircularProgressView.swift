import SwiftUI

struct CircularProgressView: View {

    let progress: Double

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.blue.opacity(0.5), lineWidth: 15)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.blue.gradient, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeIn, value: progress)
            VStack {
                Text("\((progress * 100), specifier: "%.0f")%")
                    .font(.title.bold())
                Text("Consistency")
            }
        }
        .frame(width: 150, height: 150)
        .padding(.vertical, 5)
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(progress: 0.64)
    }
}
