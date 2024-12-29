//
//  ClientViewModel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 28/12/2024.
//

import Foundation
import Firebase

@MainActor
final class ClientViewModel: ObservableObject {
    @Published var favouriteClients = [Client]()
    @Published var clients = [Client]()
    @Published var searchText = ""
    @Published var name = ""
    @Published var phoneNumber = ""
    @Published var nickname = ""
    @Published var isFavourite = false
    @Published var client: Client? = nil
    
    private var clientListener: ListenerRegistration? = nil
    
    var filteredClients: [Client] {
        guard !searchText.isEmpty else { return clients }
        return clients.filter({ $0.name.localizedCaseInsensitiveContains(searchText)})
    }
    
    let manager = FirebaseManager.shared
    
    init() {
        self.fetchClientsWithListener()
    }
    
    deinit {
        self.clientListener?.remove()
    }
    
    private func clearInformation() {
        name = ""
        phoneNumber = ""
        nickname = ""
        isFavourite = false
    }
    
    func fetchClientsWithListener() {
        guard let uid = manager.userSession?.uid else { return }
        self.clientListener = manager.userDocument(userId: uid).collection("clients").order(by: Client.CodingKeys.name.rawValue) // Optional: sort by a field
            .addSnapshotListener { [weak self] (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents found")
                    return
                }
                
                self?.clients = documents.compactMap({ try? $0.data(as: Client.self) })
            }
    }
    
    func fetchFavouriteClients() {
        guard let uid = manager.userSession?.uid else { return }
        
        manager.userDocument(userId: uid).collection("users")
            .whereField(Client.CodingKeys.isFavourite.rawValue, isEqualTo: true).getDocuments { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No client documents: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                self.favouriteClients = documents.compactMap { doc -> Client? in
                    try? doc.data(as: Client.self)
                }
            }
    }
    
    func create(name: String, phoneNumber: String, nickname: String?, isFavourite: Bool) {
        guard let uid = manager.userSession?.uid else { return }
        Task {
            try await manager.create(collectionPath: "clients", userId: uid, documentData: [Client.CodingKeys.name.rawValue: name, Client.CodingKeys.phoneNumber.rawValue: phoneNumber, Client.CodingKeys.nickname.rawValue: nickname ?? "n/a", Client.CodingKeys.isFavourite.rawValue: isFavourite])
        }
        self.clearInformation()
    }
    
    func update(clientToUpdate: Client) {
        guard let uid = manager.userSession?.uid else { return }
        manager.userCollection.document(uid).collection("clients").document(clientToUpdate.id ?? "").setData(["name": clientToUpdate.name, "phone_number": clientToUpdate.phoneNumber,"nickname": clientToUpdate.nickname ?? "n/a", "is_favourite": clientToUpdate.isFavourite], merge: true)
    }
    
    func delete(at offsets: IndexSet) {
        guard let uid = manager.userSession?.uid else { return }
        offsets.forEach { index in
            let client = clients[index]
            if let clientID = client.id {
                manager.delete(uid: uid, collectionPath: "clients", docToDelete: clientID)
            }
        }
    }
}
