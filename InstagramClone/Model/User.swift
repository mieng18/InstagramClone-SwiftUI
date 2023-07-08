//
//  User.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/5/23.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let email: String
    let profileImageUrl: String
    let fullname: String
    let userbio: String?
    var isFollowedByCurrentUser: Bool? = false
    
    var isCurrentUser: Bool { return AuthViewModel.shared.userSession?.uid == id }
}

struct UserStats {
    var following: Int
    var posts: Int
    var followers: Int
}

