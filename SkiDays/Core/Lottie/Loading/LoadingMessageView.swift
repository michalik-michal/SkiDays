//
//  LoadingMessageView.swift
//  SkiDays
//
//  Created by Michal Michalik on 22/05/2023.
//

import SwiftUI

struct LoadingMessageView: View {

    var message: String

    var body: some View {
        ZStack {
            LoadingView()
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.width)
            VStack {
                Spacer()
                Text(message)
                    .font(.title)
                    .bold()
            }
        }
    }
}

struct LoadingMessageView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingMessageView(message: "Uploading")
    }
}
