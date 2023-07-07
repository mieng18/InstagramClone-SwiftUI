//
//  FeedView.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/5/23.
//

import SwiftUI


struct FeedView: View {
    
    @ObservedObject var viewModel = FeedViewModel()
    
    var mainPost: Post?
    
    var body: some View {
        ScrollView {
            LazyVStack (alignment: .leading, spacing: 24) {
                
                if (mainPost != nil) {
                    FeedComponent(post: mainPost!)
                        .padding(.top, 10)
                }
                
                ForEach(viewModel.posts) { post in
                    if (mainPost == nil || mainPost?.id != post.id) {
                        FeedComponent(post: post)
                            .padding(.top, 10)
                    }
                }
            }
        }
    }
}
