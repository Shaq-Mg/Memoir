//
//  ServiceViewModel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 29/12/2024.
//

import Foundation
import Firebase

final class ServiceViewModel: ObservableObject {
    @Published var services = [Service]()
    @Published var searchText = ""
    @Published var title = ""
    @Published var price = ""
    @Published var duration = ""
    
    var filteredServices: [Service] {
        guard !searchText.isEmpty else { return services }
        return services.filter({ $0.title.localizedCaseInsensitiveContains(searchText)})
    }
    
    private var serviceListener: ListenerRegistration? = nil
    
    private let manager = AuthService.shared
    
    init() {
        self.fetchServicesWithListener()
    }
    
    deinit {
        self.serviceListener?.remove()
    }
    
    private func clearServiceInformation() {
        searchText = ""
        title = ""
        price = ""
        duration = ""
    }
    
    func fetchServicesWithListener() {
        guard let uid = manager.userSession?.uid else { return }
        self.serviceListener = FirebaseManager.userDocument(userId: uid).collection("services").order(by: Service.CodingKeys.title.rawValue) // Optional: sort by a field
            .addSnapshotListener { [weak self] (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents found")
                    return
                }
                
                self?.services = documents.compactMap({ try? $0.data(as: Service.self) })
            }
    }
    
    func add(title: String, price: String, duration: String) {
        guard let uid = manager.userSession?.uid else { return }
        Task {
            try await FirebaseManager.create(collectionPath: "services", userId: uid, documentData: [Service.CodingKeys.title.rawValue: title, Service.CodingKeys.price.rawValue: price, Service.CodingKeys.duration.rawValue: duration])
        }
        self.clearServiceInformation()
    }
    
    func update(serviceToUpdate: Service) {
        guard let uid = manager.userSession?.uid else { return }
        FirebaseManager.userCollection.document(uid).collection("services").document(serviceToUpdate.id ?? "").setData([Service.CodingKeys.title.rawValue: serviceToUpdate.title, Service.CodingKeys.price.rawValue: serviceToUpdate.price, Service.CodingKeys.duration.rawValue: serviceToUpdate.duration,], merge: true)
    }
    
    func delete(toDelete: Service) {
        guard let uid = manager.userSession?.uid else { return }
        FirebaseManager.userDocument(userId: uid).collection("services").document(toDelete.id ?? "").delete { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.services.removeAll { service in
                        return service.id == toDelete.id
                    }
                }
                self.fetchServicesWithListener()
            } else {
                // handle error here
                print("Failed to delete service to firestore")
            }
        }
    }
}
