//
//  FirebaseService.swift
//  Memoir
//
//  Created by Shaquille McGregor on 12/05/2025.
//

import FirebaseFirestore

typealias FirebaseModel = CustomStringConvertible & Identifiable & Codable & Equatable & Hashable

protocol FirebaseService {
    func create<T: FirebaseModel>(_ item: T, userId: String, collectionPath: String) async throws
    func fetchAll<T: FirebaseModel>(userId: String, collectionPath: String, orderBy: String) async throws -> [T]
    func load<T: FirebaseModel>(userId: String, collectionPath: String, docId: String) async throws -> T?
    func update(userId: String, collectionPath: String, docId: String, data: [String: Any]) async throws
    func delete(userId: String, collectionPath: String, docId: String) async throws
}
