//
//  ProfileActionButtons.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/5/23.
//

import SwiftUI


struct ProfileActionButtons: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    private var isFollowed: Bool { return viewModel.user.isFollowedByCurrentUser ?? false }
    
    @State var showRemoveFollowerSheet = false;
    
    var body: some View {
        if viewModel.user.isCurrentUser {
            Button(action: {}) {
                Text("Edit Profile")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black262626)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 29)
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.grayBorder, lineWidth: 0.5)
                    )
            }
        } else {
            
            HStack {
                Button(action: {
                    if (isFollowed) {
                        showRemoveFollowerSheet = true
                    } else {
                        viewModel.follow()
                    }
                }) {
                    Text(isFollowed ? "Following" : "Follow")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(isFollowed ? .black262626 : .white)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 32)
                        .background(isFollowed ? .white : .blue)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: isFollowed ? 1 : 0)
                        )
                        .cornerRadius(3)
                }
                .confirmationDialog("Unfollow user", isPresented: $showRemoveFollowerSheet) {
                    Button(role: .destructive, action: {
                        viewModel.unfollow()
                        showRemoveFollowerSheet = false
                    }) {
                        Text("Unfollow")
                    }
                    
                    Button(role: .cancel, action: { showRemoveFollowerSheet = false }) {
                        Text("Cancel")
                    }
                    
                }
                
                Button(action: {}) {
                    Text("Message")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black262626)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 32)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                }
            }

        }
    }
}

