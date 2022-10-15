import SwiftUI

struct TrainingRowView: View {

    let skiDay: SkiDay

    var body: some View {
        HStack {
            VStack(spacing: 30) {
                Text("\(skiDay.date)")
                    .font(.system(size: 20))
                    .frame(width: 100)
                    .foregroundColor(.blackWhite)
                Text("📍\(skiDay.place)")
                    .lineLimit(0)
                    .frame(width: 100)
                    .font(.system(size: 20))
                    .foregroundColor(.blackWhite)
            }
            Spacer()
            NavigationLink {
                TrainingDetailsView(skiDay: skiDay)
            }label: {
                Text(skiDay.discipline)
                    .bold()
                    .frame(width: 80)
                    .font(.system(size: 25))
                    .foregroundColor(.blackWhite)
            }
            Spacer()
            VStack(spacing: 30) {
                Image(systemName: "video")
                    .frame(width: 100)
                    .font(.system(size: 20))
                    .foregroundColor(.blackWhite)
                Text(skiDay.conditions)
                    .frame(width: 100)
                    .font(.system(size: 20))
                    .foregroundColor(.blackWhite)
            }
        }
        .padding(.horizontal)
        .foregroundColor(.white)
        .padding(.vertical, 30)
        .background(Color.secondayBackground)
        .cornerRadius(20)
    }
}

struct TrainingRowView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingRowView(skiDay: SkiDay(date: "11/08/22",
                                       discipline: "SL",
                                       gates: 12,
                                       notes: "es",
                                       place: "Sierra nevada",
                                       runs: 0,
                                       consistency: 75.2,
                                       conditions: "bad",
                                       slopeProfile: "",
                                       skis: "",
                                       video: ""))
    }
}
