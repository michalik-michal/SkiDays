import SwiftUI

struct ErrorView: View {
    var body: some View {
        VStack(spacing: 40) {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray.opacity(0.5))
            Text("Oops, ther was some error")
                .font(.title3.bold())
                .foregroundColor(.gray.opacity(0.5))
                .padding(.horizontal)
        }
        .frame(width: 280, height: 300)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
