//
//  Post.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/5/23.
//

import SwiftUI

import FirebaseFirestoreSwift
import Firebase

struct Post: Identifiable, Decodable {
    @DocumentID var id: String?
    let ownerUid: String
    let ownerUsername: String
    let caption: String
    var likes: Int
    let imageUrl: String
    let timestamp: Timestamp
    let ownerImageUrl: String
    
    var userDidLike: Bool? = false
}
