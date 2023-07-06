//
//  PostService.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/5/23.
//

import SwiftUI


struct PostService {
    
    static func getAllPosts(completion: @escaping (_ posts: [Post]) -> Void) {
        FIRPostsCollection
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else { return }

                let posts = documents.compactMap { doc in
                    try? doc.data(as: Post.self)
                }
                
                completion(posts)
        }
    }
    
    static func getByUser(fromUser: String, completion: @escaping (_ posts: [Post]) -> Void) {
        FIRPostsCollection
            .order(by: "timestamp", descending: true)
            .whereField("ownerUid", isEqualTo: fromUser)
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else { return }
                
                let posts = documents.compactMap { doc in
                    try? doc.data(as: Post.self)
                }
                
                completion(posts)
            }
    }
    
}
