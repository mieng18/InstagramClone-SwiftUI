//
//  FeedViewModel.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/5/23.
//

import SwiftUI

class FeedViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    
    init () {
        fetchPosts()
    }
    
    func fetchPosts() {
        PostService.getAllPosts { posts in self.posts = posts }
    }
    
}
