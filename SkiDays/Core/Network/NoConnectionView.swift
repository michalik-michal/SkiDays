import SwiftUI

struct NoConnectionView: View {
    var body: some View {
        VStack {
            LoadingView()
            Text("No internet connection")
                .font(.title2).bold()
                .foregroundColor(.blackWhite)
            Text("Check your internet connection and try again.")
                .font(.title3)
                .foregroundColor(.gray)
                .padding(.horizontal)
                .multilineTextAlignment(.center)
        }
        //.frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(30)
        .background(Color.background)

    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        NoConnectionView()
    }
}
