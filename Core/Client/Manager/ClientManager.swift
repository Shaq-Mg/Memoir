//
//  ClientManager.swift
//  Memoir
//
//  Created by Shaquille McGregor on 12/05/2025.
//

import Firebase
import FirebaseAuth

@MainActor
class ClientManager: ObservableObject {
    @Published var name = ""
    @Published var phoneNumber = ""
    @Published var note = ""
    @Published var isFavourite = false
    @Published var searchText = ""
    
    @Published var clients = [Client]()
    @Published var favouriteClients = [Client]()
    @Published var client: Client?
    
    var filteredClients: [Client] {
        guard !searchText.isEmpty else { return clients }
        return clients.filter({ $0.name.localizedCaseInsensitiveContains(searchText)})
    }
    
    init() {
        clearFormInformation()
        Task { try await fetch() }
    }
    
    func clearFormInformation() {
        searchText = ""
        name = ""
        phoneNumber = ""
        note = ""
        isFavourite = false
    }
    
    func fetch() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        clients = try await FirebaseService.fetchAll(userId: uid, collectionPath: "clients", orderBy: Client.CodingKeys.name.rawValue)
    }
    
    func load(type: Client) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        client = try await FirebaseService.load(userId: uid, collectionPath: "clients", docId: type.id)
    }
    
    func save() async throws  {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let clientData = Client(name: name, phoneNumber: phoneNumber, note: note, isFavourite: isFavourite)
        try await FirebaseService.create(clientData, userId: uid, collectionPath: "clients")
        try await fetch()
    }
    
    func delete(clientToDelete: Client) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        try await FirebaseService<Client>.delete(userId: uid, collectionPath: "clients", docId: clientToDelete.id)
        try await fetch()
    }
    
    func update(clientToUpdate: Client) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let data: [String: Any] = [Client.CodingKeys.name.rawValue: name, Client.CodingKeys.phoneNumber.rawValue: phoneNumber, Client.CodingKeys.note.rawValue: note, Client.CodingKeys.isFavourite.rawValue: isFavourite]
        
        try await FirebaseService<Client>.update(userId: uid, collectionPath: "clients", docId: clientToUpdate.id, data: data)
        try await fetch()
    }
    
    func fetchFavouriteClients() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        do {
            let snapshot = try await FirebaseConstants.collectionPath(userId: uid, collectionId: "clients")
                .whereField("is_favourite", isEqualTo: true)
                .getDocuments()
            
            favouriteClients = try snapshot.documents.compactMap {
                try $0.data(as: Client.self)
            }
        } catch {
            print("Error fetching favourite clients: \(error.localizedDescription)")
        }
    }
}
