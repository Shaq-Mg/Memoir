//
//  AuthService.swift
//  Memoir
//
//  Created by Shaquille McGregor on 11/05/2025.
//

import FirebaseAuth
import FirebaseFirestore

class AuthService {
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            userSession = result.user
            print("DEBUG: Successfully signed in user \(result.user.uid)")
        } catch {
            print("DEBUG: Failed to login user \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, name: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            userSession = result.user
            try await uploadUserData(uid: result.user.uid, name: name, email: email, profileImageUrl: nil)
            print("DEBUG: Created user \(result.user.uid)")
        } catch {
            print("DEBUG: Failed to created user \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() async throws {
        do {
            guard let user = Auth.auth().currentUser else { return }
            let uid = user.uid
            // Step 1: Delete user document from Firestore
            try await FirebaseConstants.userDocument(userId: uid).delete()
            // Step 2: Delete user authentication account
            try await user.delete()
        } catch {
            print("DEBUG: Failed to delete account from firestore. \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        userSession = nil
    }
    
    @MainActor
    private func uploadUserData(uid: String, name: String, email: String, profileImageUrl: String?) async throws {
        let user = User(name: name, email: email, profileImageUrl: profileImageUrl ?? "n/a")
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        try await FirebaseConstants.userDocument(userId: uid).setData(userData)
    }
}
