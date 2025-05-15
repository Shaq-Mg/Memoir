//
//  FirebaseService.swift
//  Memoir
//
//  Created by Shaquille McGregor on 12/05/2025.
//

import FirebaseFirestore

typealias FirebaseModel = CustomStringConvertible & Identifiable & Codable & Equatable & Hashable

class FirebaseService {
    
    static let shared = FirebaseService()
    
    private init() { }
    
    func create<T: FirebaseModel>(_ item: T, userId: String, collectionPath: String) async throws {
        _ = try FirebaseConstants.userDocument(userId: userId).collection(collectionPath).addDocument(from: item)
    }
    
    func fetchAll<T: FirebaseModel>(userId: String, collectionPath: String, orderBy: String) async throws -> [T] {
        let snapshot = try await FirebaseConstants.collectionPath(userId: userId, collectionId: collectionPath).order(by: orderBy).getDocuments()
        return try snapshot.documents.compactMap { try $0.data(as: T.self) }
    }
    
    func load<T: FirebaseModel>(userId: String, collectionPath: String, docId: String) async throws -> T? {
        let doc = try await FirebaseConstants.collectionPath(userId: userId, collectionId: collectionPath).document(docId).getDocument()
        return try doc.data(as: T.self)
    }
    
    func update(userId: String, collectionPath: String, docId: String, data: [String: Any]) async throws {
        try await FirebaseConstants.collectionPath(userId: userId, collectionId: collectionPath).document(docId).updateData(data)
    }
    
    func delete(userId: String, collectionPath: String, docId: String) async throws {
        try await FirebaseConstants.collectionPath(userId: userId, collectionId: collectionPath).document(docId).delete()
    }
}
