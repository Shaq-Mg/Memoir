//
//  EditServiceViewModel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 15/05/2025.
//

import FirebaseAuth
import FirebaseFirestore

class EditServiceViewModel: ObservableObject {
    @Published var title = ""
    @Published var price = ""
    
    @Published var selectedService: Service?
    
    private let manager = ServiceManager.shared
    
    var isValid: Bool {
        return !title.isEmpty && !price.isEmpty
        && title.count >= 2 && (Double(price) ?? 0 > Double(0))
    }
    
    init() {
        clearInformation()
    }
    
    private func clearInformation() {
        title = ""
        price = ""
    }
    
    func load(_ type: Service) async throws {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        selectedService = try await manager.load(userId: userId, collectionPath: "serivces", docId: type.id)
    }
    
    func delete(for docToDelete: Service) async throws {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        try await manager.delete(userId: userId, collectionPath: "services", docId: docToDelete.docId ?? "")
    }
    
    func update(for docToUpdate: Service) async throws {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let data: [String: Any] = [Service.CodingKeys.title.rawValue: title,
                                   Service.CodingKeys.price.rawValue: price]
        try await manager.update(userId: userId, collectionPath: "services", docId: docToUpdate.docId ?? "", data: data)
    }
}
