//
//  AppointmentManager.swift
//  Memoir
//
//  Created by Shaquille McGregor on 17/05/2025.
//

import FirebaseAuth
import FirebaseFirestore

class AppointmentManager: FirebaseService {
    
    static let shared = AppointmentManager()
    
    private init() { }
    
    func create<T>(_ item: T, userId: String, collectionPath: String) async throws where T : CustomStringConvertible, T : Decodable, T : Encodable, T : Hashable, T : Identifiable {
        _ = try FirebaseConstants.userDocument(userId: userId).collection(collectionPath).addDocument(from: item)
    }
    
    func fetchAll<T>(userId: String, collectionPath: String, orderBy: String) async throws -> [T] where T : CustomStringConvertible, T : Decodable, T : Encodable, T : Hashable, T : Identifiable {
        let snapshot = try await FirebaseConstants.collectionPath(userId: userId, collectionId: collectionPath).order(by: orderBy).getDocuments()
        return try snapshot.documents.compactMap { try $0.data(as: T.self) }
    }
    
    func load<T>(userId: String, collectionPath: String, docId: String) async throws -> T? where T : CustomStringConvertible, T : Decodable, T : Encodable, T : Hashable, T : Identifiable {
        let doc = try await FirebaseConstants.collectionPath(userId: userId, collectionId: collectionPath).document(docId).getDocument()
        return try doc.data(as: T.self)
    }
    
    func update(userId: String, collectionPath: String, docId: String, data: [String : Any]) async throws {
        try await FirebaseConstants.collectionPath(userId: userId, collectionId: collectionPath).document(docId).updateData(data)
    }
    
    func delete(userId: String, collectionPath: String, docId: String) async throws {
        try await FirebaseConstants.collectionPath(userId: userId, collectionId: collectionPath).document(docId).delete()
    }
}
