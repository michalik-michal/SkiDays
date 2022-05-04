//
//  SettingsView.swift
//  SkiDays
//
//  Created by MacOS on 04/05/2022.
//

import SwiftUI
import Firebase

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    backButton
                    Spacer()
                }
                HStack{
                    Text("Settings")
                        .font(.largeTitle).bold()
                    Spacer()
                }
                .padding(.bottom, 300)
                
                signoutButton
                
                Text("More to come")
                    .font(.system(size: 50))
            }
        }
        .navigationBarTitle("Settings")
        .navigationBarHidden(true)
        .padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView{
    
    var backButton: some View{
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
    }
    
    var signoutButton: some View{
        Button {
            viewModel.signOut()
        } label: {
            Text("Sign Out")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .clipShape(Capsule())
                
        }
        .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
    }
}
