//
//  AddTrainingView.swift
//  SkiDays
//
//  Created by MacOS on 29/04/2022.
//

import SwiftUI

struct AddTrainingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView{
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.darkerBlue)
                        .font(.system(size: 25))
                        .frame(width: 30, height: 30)
                        .padding(.top, 15)
                        .padding(.bottom, 5)
                }
                Spacer()
            }
            Text("Add new ski day")
        }
        .navigationBarHidden(true)
        .padding()
    }
}

struct AddTrainingView_Previews: PreviewProvider {
    static var previews: some View {
        AddTrainingView()
    }
}
