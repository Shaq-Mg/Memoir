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
    
    private let firebaseService = FirebaseService.shared
    
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
        try await firebaseService.create(clientData, userId: uid, collectionPath: "clients")
    }
}
