//
//  FirebaseManager.swift
//  Memoir
//
//  Created by Shaquille McGregor on 27/12/2024.
//

import Foundation
import FirebaseAuth
import Firebase
import Combine

final class FirebaseManager {
    static let userCollection = Firestore.firestore().collection("users")
    
    private init() { }
    
    static func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    static func create(collectionPath: String, userId: String, documentData: [String:Any]) async throws {
        let document = userDocument(userId: userId).collection(collectionPath).document()
        try await document.setData(documentData, merge: false)
    }
    
    static func update<T: Identifiable>(collectionPath: String, uid: String, typeToUpdate: T, typeDictionary: [String:Any]) {
        userDocument(userId: uid).collection(collectionPath).document("\(typeToUpdate.id)").updateData(typeDictionary)
    }
    
    static func delete(uid: String, collectionPath: String, documentID: String) async throws {
        try await userDocument(userId: uid).collection(collectionPath).document(documentID).delete()
    }
    
    static func fetch<T: Codable & Identifiable>(collectionPath: String, uid: String, as type: T.Type) async throws -> [T] {
        let snapshot = try await userDocument(userId: uid).collection(collectionPath).getDocuments()
        
        return try snapshot.documents.compactMap { document in
            try document.data(as: T.self)
        }
    }
}

extension Query {
    func getDocuments<T>(type as: T.Type) async throws -> [T] where T : Decodable {
        let snapshot = try await self.getDocuments()
        
        return try snapshot.documents.map({ doc in
            try doc.data(as: T.self)
        })
    }
}
