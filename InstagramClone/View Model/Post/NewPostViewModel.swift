//
//  NewPostViewModel.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/6/23.
//

import SwiftUI

import SwiftUI
import Firebase

class NewPostViewModel: ObservableObject {
    
    @Published var isPosting: Bool = false
    
    func uploadPost(caption: String, image: UIImage, completion: @escaping FirestoreCompletion) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        
        isPosting = true
        
        ImageUploader.uploadImage(image: image, type: .post) { imageUrl in
            let data = [
                "caption": caption,
                "timestamp": Timestamp(date: Date()),
                "likes": 0,
                "imageUrl": imageUrl,
                "ownerUid": user.id!,
                "ownerImageUrl": user.profileImageUrl,
                "ownerUsername": user.username
            ] as [String : Any]
            
            FIRPostsCollection.addDocument(data: data) { error in
                self.isPosting = false
                completion(error)
            }
        }
    }
}
