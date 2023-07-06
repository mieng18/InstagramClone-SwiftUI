//
//  ProfileView.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/5/23.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    init(user: User) {
        viewModel = ProfileViewModel(user: user);
    }
    
    var body: some View {
        ScrollView {
            VStack (spacing: 32) {
                ProfileHeaderView(viewModel: viewModel)
                    .padding(.top, 16)
                PostGridView(config: .profile(viewModel.user.id ?? ""))
            }
        }
    }
}
