//
//  ServiceFormViewModel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 15/05/2025.
//

import FirebaseAuth
import FirebaseFirestore

@MainActor
class ServiceFormViewModel: ObservableObject {
    @Published var title = ""
    @Published var price = ""
    
    private let firebaseManager = FirebaseManager.shared
    
    var isFormValid: Bool {
        return !title.isEmpty && !price.isEmpty
        && title.count >= 2 && (Double(price) ?? 0 > Double(0))
    }
    
    init() {
        clearFormInformation()
    }
    
    private func clearFormInformation() {
        title = ""
        price = ""
    }
    
    func save() async throws {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let serivce = Service(title: title, price: Double(price) ?? 0)
        try await firebaseManager.create(serivce, userId: userId, collectionPath: "services")
        clearFormInformation()
    }
}
