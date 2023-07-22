//
//  HomeTab.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/5/23.
//

import SwiftUI

struct HomeTab: View {
    var body: some View {
        VStack(spacing: 0){
            HStack{
                Image("instagram")
                    .resizable()
                    .frame(width: 110, height: 36)
                
                Spacer()
                
                Image(systemName: "heart")
                    .font(.title2)
                    .padding([.trailing], 5)
                
            }
            .padding([.leading, .trailing], 20)
            
            FeedView()
        }
    }
}

struct HomeTab_Previews: PreviewProvider {
    static var previews: some View {
        HomeTab()
    }
}
