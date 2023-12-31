//
//  ProfileHeaderView.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/5/23.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    var user: User { return viewModel.user }
    
    var body: some View {
        VStack {
            HStack {
                KFImage(URL(string: user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 82, height: 82)
                    .clipShape(Circle())
                
                Spacer()

                HStack {
                    UserStatView(title: "Posts", value: viewModel.userStats.posts)
                    UserStatView(title: "Followers", value: viewModel.userStats.followers)
                    UserStatView(title: "Following", value: viewModel.userStats.following)
                }
            }
            
            VStack(alignment: .leading) {
                Text(user.fullname)
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.top, 10)
                
                Text(user.userbio ?? "")
                    .font(.system(size: 16, weight: .regular))
                    .padding(.top, -3)

    
            }
            .hAlign(.leading)
            
            ProfileActionButtons(viewModel: viewModel)
            
        }
        .padding(.horizontal, 16)
    }
}
