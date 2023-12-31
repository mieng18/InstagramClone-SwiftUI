//
//  FeedComponent.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/5/23.
//

import SwiftUI
import Kingfisher

struct FeedComponent: View {
    
    @ObservedObject var viewModel: FeedCellViewModel
    
    var post: Post { return viewModel.post }
    var didLike: Bool { return post.userDidLike ?? false }
    
    init (post: Post) {
        viewModel = FeedCellViewModel(post: post)
    }
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0) {
            
            // user information
            HStack {
                KFImage(URL(string: post.ownerImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipped()
                    .cornerRadius(18)
                
                Text(post.ownerUsername)
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding(10)
            
            KFImage(URL(string: post.imageUrl))
                .resizable()
                .background(Color(red: 0, green: 0, blue: 0, opacity: 0.2))
                .scaledToFill()
                .frame(maxHeight: 450)
                .clipped()
            
            HStack (spacing: 18){
                Button(action: {
                    if didLike {
                        viewModel.unlike()
                    } else {
                        viewModel.like()
                    }
                }, label: {
                    Image(systemName: didLike ? "heart.fill" : "heart")
                        .resizable()
                        .foregroundColor(didLike ? .red : .black)
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                })
                
                NavigationLink {
//                    CommentsView(post: viewModel.post)
                } label: {
                    Image(systemName: "bubble.right")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                }

                Button(action: {}) {
                    Image(systemName: "paperplane")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                }
            }
            .padding(.leading, 10)
            .padding(.top,13)
            .foregroundColor(.black)
            
            Text("\(post.likes) likes")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black)
                .padding([.top, .bottom], 8)
                .padding(.leading, 10)
            
            HStack {
                Text(post.ownerUsername + " ")
                    .font(.system(size: 14, weight: .semibold)) +
                
                Text(post.caption)
                    .font(.system(size: 14, weight: .regular))
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
            
            Text(viewModel.timestampString)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.leading, 10)
                .padding(.top,8)
        }
    }
}
