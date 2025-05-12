//
//  FirebaseService.swift
//  Memoir
//
//  Created by Shaquille McGregor on 12/05/2025.
//

import FirebaseFirestore

typealias FirebaseModel = CustomStringConvertible & Identifiable & Codable & Equatable

class FirebaseService<T: FirebaseModel> {
    private let db = Firestore.firestore()
    
    static func create(_ item: T, userId: String, collectionPath: String) async throws {
        _ = try FirebaseConstants.userDocument(userId: userId).collection(collectionPath).addDocument(from: item)
    }
    
    static func fetchAll(userId: String, collectionPath: String) async throws -> [T] {
        let snapshot = try await FirebaseConstants.userDocument(userId: userId).collection(collectionPath).getDocuments()
        return try snapshot.documents.compactMap { try $0.data(as: T.self) }
    }
    
    static func load(userId: String, collectionPath: String, docId: String) async throws -> T? {
        let doc = try await FirebaseConstants.userDocument(userId: userId).collection(collectionPath).document(docId).getDocument()
        return try doc.data(as: T.self)
    }
    
    static func update(userId: String, collectionPath: String, docId: String, typeToUpdate: [String: Any]) async throws {
        try await FirebaseConstants.userDocument(userId: userId).collection(collectionPath).document(docId).setData(typeToUpdate, merge: true)
    }
    
    static func delete(userId: String, collectionPath: String, docId: String) async throws {
        try await FirebaseConstants.userDocument(userId: userId).collection(collectionPath).document(docId).delete()
    }
}
