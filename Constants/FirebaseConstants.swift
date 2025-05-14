//
//  FirebaseConstants.swift
//  Memoir
//
//  Created by Shaquille McGregor on 11/05/2025.
//

import FirebaseAuth
import Firebase

enum FirebaseConstants {
    static let userCollection = Firestore.firestore().collection("users")
    
    static func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    static func collectionPath(userId: String, collectionId: String) -> CollectionReference {
        userCollection.document(userId).collection(collectionId)
    }
}
