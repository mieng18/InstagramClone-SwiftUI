//
//  HomeTab.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/5/23.
//

import SwiftUI

struct HomeTab: View {
    var body: some View {
        VStack{
            HStack{
                Image("instagram")
                    .resizable()
                    .frame(width: 120, height: 40)
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
