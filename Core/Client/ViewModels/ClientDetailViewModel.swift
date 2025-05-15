//
//  ClientDetailViewModel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 14/05/2025.
//

import FirebaseAuth
import FirebaseFirestore

@MainActor
final class ClientDetailViewModel: ObservableObject {
    @Published var name = ""
    @Published var phoneNumber = ""
    @Published var note = ""
    @Published var isFavourite = false
    
    @Published var client: Client?
    
    private let manager = ClientManager.shared
    
    init() {
        clearInformation()
    }
    
    private func clearInformation() {
        name = ""
        phoneNumber = ""
        note = ""
        isFavourite = false
    }
    
    func load(type: Client) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        client = try await manager.load(userId: uid, collectionPath: "clients", docId: type.id)
    }
    
    func delete(clientToDelete: Client) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        try await manager.delete(userId: uid, collectionPath: "clients", docId: clientToDelete.id)
    }
    
    func update(clientToUpdate: Client) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let data: [String: Any] = [Client.CodingKeys.name.rawValue: name, Client.CodingKeys.phoneNumber.rawValue: phoneNumber, Client.CodingKeys.note.rawValue: note, Client.CodingKeys.isFavourite.rawValue: isFavourite]
        
        try await manager.update(userId: uid, collectionPath: "clients", docId: clientToUpdate.id, data: data)
    }
}
