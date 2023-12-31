//
//  PostGridView.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/5/23.
//


import SwiftUI
import Kingfisher

struct PostGridView: View {
    private let items = [GridItem(), GridItem(), GridItem()]
    private let width = UIScreen.main.bounds.width / 3
    
    let config: PostGridConfiguration
    @ObservedObject var viewModel: PostGridViewModel
    
    init (config: PostGridConfiguration) {
        self.config = config
        self.viewModel = PostGridViewModel(config: config)
    }
    
    var body: some View {
        LazyVGrid(columns: items, spacing: 2) {
            ForEach(viewModel.posts) { post in
                NavigationLink {
                    FeedView(viewModel: FeedViewModel(), mainPost: post)
                } label: {
                    KFImage(URL(string: post.imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: width)
                        .background(Color(red: 0, green: 0, blue: 0, opacity: 0.2))
                        .clipped()
                }

            }
        }
        
    }
}


