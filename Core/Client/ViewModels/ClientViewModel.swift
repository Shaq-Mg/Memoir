//
//  ClientViewModel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 15/05/2025.
//

import Firebase
import FirebaseAuth

@MainActor
class ClientViewModel: ObservableObject {
    @Published var searchText = ""
    
    @Published var clients = [Client]()
    @Published var favouriteClients = [Client]()
    
    private let firebaseManager = FirebaseManager.shared
    
    var filteredClients: [Client] {
        guard !searchText.isEmpty else { return clients }
        return clients.filter({ $0.name.localizedCaseInsensitiveContains(searchText)})
    }
    
    init() {
        searchText = ""
        Task { try await fetch() }
        Task { await fetchFavouriteClients() }
    }
    
    func fetch() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        clients = try await firebaseManager.fetchAll(userId: uid, collectionPath: "clients", orderBy: Client.CodingKeys.name.rawValue)
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
