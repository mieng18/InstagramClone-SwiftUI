//
//  FirebaseConstants.swift
//  InstagramClone
//
//  Created by mai nguyen on 7/5/23.
//

import Foundation
import Firebase

let FIRUsersCollection = Firestore.firestore().collection("users")

let FIRFollowersCollection = Firestore.firestore().collection("followers")

let FIRFollowingCollection = Firestore.firestore().collection("following")

let FIRPostsCollection = Firestore.firestore().collection("posts")

let FIRNotificationsCollection = Firestore.firestore().collection("notifications")
