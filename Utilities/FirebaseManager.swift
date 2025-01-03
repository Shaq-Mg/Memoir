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
    @Published var availableTimes = [Date]()
    @Published var userSession: FirebaseAuth.User?
    @Published var user: User? = nil
    
    static let shared = FirebaseManager()
    let userCollection = Firestore.firestore().collection("users")
    
    private init() { }
    
    func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    func create(collectionPath: String, userId: String, documentData: [String:Any]) async throws {
        let document = userDocument(userId: userId).collection(collectionPath).document()
        try await document.setData(documentData, merge: false)
    }
    
    func update<T: Identifiable>(collectionPath: String, uid: String, typeToUpdate: T, typeDictionary: [String:Any]) {
        userDocument(userId: uid).collection(collectionPath).document("\(typeToUpdate.id)").updateData(typeDictionary)
    }
    
    func delete(uid: String, collectionPath: String, docToDelete: String) {
        userDocument(userId: uid).collection(collectionPath).document(docToDelete).delete { error in
            if let error = error {
                print("Failed to delete document from database \(error)")
            } else {
                print("Document successfully deleted")
            }
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
