//
//  MenuViewModel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 23/06/2025.
//

import Combine
import FirebaseAuth
import FirebaseFirestore

final class MenuViewModel: ObservableObject {
    @Published var currentUser: User?

    init() {
        Task { await fetchUser() }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await FirebaseConstants.userDocument(userId: uid).getDocument() else { return }
        currentUser = try? snapshot.data(as: User.self)
    }
}
