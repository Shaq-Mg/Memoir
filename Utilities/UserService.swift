//
//  UserService.swift
//  Memoir
//
//  Created by Shaquille McGregor on 11/05/2025.
//

import FirebaseAuth
import FirebaseFirestore

class UserService {
    @Published var currentUser: User?
    
    static let shared = UserService()
    
    init() {
        Task { try await fetchCurrentUser() }
    }
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await FirebaseConstants.userDocument(userId: uid).getDocument()
        let user = try snapshot.data(as: User.self)
        currentUser = user
        
        print("DEBUG: Successfully fetched current user \(user)")
    }
    
    func reset() {
        currentUser = nil
    }
    
    func updateUserProfileImage(withImageUrl imageUrl: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        try await FirebaseConstants.userDocument(userId: uid).updateData([
            User.CodingKeys.profileImageUrl.rawValue: imageUrl
        ])
        currentUser?.profileImageUrl = imageUrl
    }
}
