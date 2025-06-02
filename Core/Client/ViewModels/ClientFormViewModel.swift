//
//  ClientFormViewModel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 14/05/2025.
//

import FirebaseAuth
import FirebaseFirestore

final class ClientFormViewModel: ObservableObject {
    @Published var name = ""
    @Published var phoneNumber = ""
    @Published var note = ""
    @Published var isFavourite = false
    
    private let firebaseManager = FirebaseManager.shared
    
    var isFormValid: Bool {
        return !name.isEmpty && !phoneNumber.isEmpty
        && name.count >= 2 && phoneNumber.count == 11
    }
    
    init() {
        clearFormInformation()
    }
    
    private func clearFormInformation() {
        name = ""
        phoneNumber = ""
        note = ""
        isFavourite = false
    }
    
    func save() async throws  {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let clientData = Client(name: name, phoneNumber: phoneNumber, note: note, isFavourite: isFavourite)
        try await firebaseManager.create(clientData, userId: uid, collectionPath: "clients")
    }
}
