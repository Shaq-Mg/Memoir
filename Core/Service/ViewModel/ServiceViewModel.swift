//
//  ServiceViewModel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 15/05/2025.
//

import Firebase
import FirebaseAuth

@MainActor
class ServiceViewModel: ObservableObject {
    @Published var services = [Service]()
    
    @Published var searchText = ""
    
    private let manager = ServiceManager.shared
    
    var filteredServices: [Service] {
        guard !searchText.isEmpty else { return services }
        return services.filter({ $0.title.localizedCaseInsensitiveContains(searchText)})
    }
    
    init() {
        searchText = ""
        Task { try await fetchServices() }
    }
    
    func fetchServices() async throws {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        services = try await manager.fetchAll(userId: userId, collectionPath: "services", orderBy: Service.CodingKeys.title.rawValue)
    }
}
