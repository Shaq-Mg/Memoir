//
//  FirebaseService.swift
//  Memoir
//
//  Created by Shaquille McGregor on 12/05/2025.
//

import FirebaseFirestore

typealias FirebaseModel = CustomStringConvertible & Identifiable & Codable & Equatable & Hashable

class FirebaseService<T: FirebaseModel> {
    
    static func create(_ item: T, userId: String, collectionPath: String) async throws {
        _ = try FirebaseConstants.userDocument(userId: userId).collection(collectionPath).addDocument(from: item)
    }
    
    static func fetchAll(userId: String, collectionPath: String, orderBy: String) async throws -> [T] {
        let snapshot = try await FirebaseConstants.collectionPath(userId: userId, collectionId: collectionPath).order(by: orderBy).getDocuments()
        return try snapshot.documents.compactMap { try $0.data(as: T.self) }
    }
    
    static func load(userId: String, collectionPath: String, docId: String) async throws -> T? {
        let doc = try await FirebaseConstants.collectionPath(userId: userId, collectionId: collectionPath).document(docId).getDocument()
        return try doc.data(as: T.self)
    }
    
    static func update(userId: String, collectionPath: String, docId: String, data: [String: Any]) async throws {
        try await FirebaseConstants.collectionPath(userId: userId, collectionId: collectionPath).document(docId).updateData(data)
    }
    
    static func delete(userId: String, collectionPath: String, docId: String) async throws {
        try await FirebaseConstants.collectionPath(userId: userId, collectionId: collectionPath).document(docId).delete()
    }
}
