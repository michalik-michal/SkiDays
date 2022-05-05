//
//  FilteredDaysView.swift
//  SkiDays
//
//  Created by MacOS on 03/05/2022.
//

import SwiftUI

struct FilteredDaysView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: FilteredDaysViewModel
    let discipline: String
    init(user: User, discipline: String){
        self.viewModel = FilteredDaysViewModel(user: user)
        self.discipline = discipline
    }
    
    
    var title: String{
        switch discipline{
        case "SL":
            return "Slalom"
        case "GS":
            return "Giant Slalom"
        case "SG":
            return "Super G"
        case "DH":
            return "Downhill"
        case "FREE":
            return "Free Skiing"
        case "PARA":
            return "Paralell"
        default:
            return ""
        }
    }
    
    var body: some View {
        ScrollView{
            LazyVStack(alignment: .leading, spacing: 15){
                backButton
                HStack{
                    Text(title)
                        .font(.largeTitle).bold()
                    Spacer()
                }
                ForEach(viewModel.skiDays){skiDay in
                    if skiDay.discipline.contains(discipline){
                        TrainingRowView(skiDay: skiDay)
                    }
                }
            }
        }
        .padding()
        .navigationBarHidden(true)
    }
}

//struct FilteredDaysView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredDaysView(discipline: "SL")
//    }
//}

extension FilteredDaysView{
    
    var backButton: some View{
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "arrow.left")
                .foregroundColor(.darkerBlue)
                .font(.system(size: 25))
                .frame(width: 30, height: 30)
                .padding(.top, 15)
        }
    }
}
