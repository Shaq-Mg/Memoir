//
//  ClientViewModel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 12/05/2025.
//

import FirebaseAuth

@MainActor
class ClientViewModel: ObservableObject {
    @Published var name = ""
    @Published var phoneNumber = ""
    @Published var note = ""
    @Published var isFavourite = false
    
    @Published var clients = [Client]()
    @Published var favouriteClients = [Client]()
    @Published var client: Client? = nil
    
    func clearFormInformation() {
        name = ""
        phoneNumber = ""
        note = ""
        isFavourite = false
    }
    
    func fetchClients() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        clients = try await FirebaseService.fetchAll(userId: uid, collectionPath: "clients")
    }
    
    func load(type: Client) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        client = try await FirebaseService.load(userId: uid, collectionPath: "clients", docId: type.id)
    }
    
    func save() async throws  {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let clientData = Client(name: name, phoneNumber: phoneNumber, note: note, isFavourite: isFavourite)
        try await FirebaseService.create(clientData, userId: uid, collectionPath: "clients")
    }
    
    func delete(typeToDelete: Client) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        try await FirebaseService<Client>.delete(userId: uid, collectionPath: "clients", docId: typeToDelete.id)
    }
    
    func update(typeToUpdate: Client) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        try await FirebaseService<Client>.update(userId: uid, collectionPath: "clients", docId: typeToUpdate.id, typeToUpdate: [Client.CodingKeys.name.rawValue: typeToUpdate.name, Client.CodingKeys.phoneNumber.rawValue: typeToUpdate.phoneNumber, Client.CodingKeys.note.rawValue: typeToUpdate.note ?? "", Client.CodingKeys.isFavourite.rawValue: typeToUpdate.isFavourite])
    }
    
    func fetchFavouriteContacts() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        do {
            let snapshot = try await FirebaseConstants.userDocument(userId: uid).collection("clients")
                .whereField("is_favourite", isEqualTo: true)
                .getDocuments()
            
            self.favouriteClients = try snapshot.documents.compactMap {
                try $0.data(as: Client.self)
            }
        } catch {
            print("Error fetching favourite clients: \(error.localizedDescription)")
        }
    }
}

