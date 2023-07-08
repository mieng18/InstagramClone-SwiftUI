//
//  SettingView.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/8/23.
//

import SwiftUI

struct SettingView: View {

    var body: some View {
        VStack{
            HStack(spacing:20){
                Image(systemName: "chevron.backward")
                Spacer()
        
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    Task{
                        await
                        AuthViewModel.shared.signOut()
                    }
                },
                label: {
                    Text("Log out")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black262626)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 29)
                        
                })
                .background(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.grayBorder, lineWidth: 0.5)
                )
            }
            .hAlign(.center)
            .padding(.all,16)
            
        }
        
    }
}


