//
//  AuthService.swift
//  Memoir
//
//  Created by Shaquille McGregor on 27/12/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class AuthService {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    static let shared = AuthService()
    
    private init() {  }
   
    func signInUser(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else {
            return // handle error
        }
        try await user.delete()
    }
    
    func updatePassword(password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            return // hnadle error
        }
        try await user.updatePassword(to: password)
    }
    
    func updateEmail(email: String) async throws {
        //        guard let user = Auth.auth().currentUser else {
        //            return // hnadle error
        //        }
        //        try await user.updateEmail(to: email)
    }
    
    func restPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func updatePremiumStatus(userId: String, isPremium: Bool) async throws {
        let data: [String:Any] = [ User.CodingKeys.isPremium.rawValue : isPremium ]
        try await Firestore.firestore().document(userId).updateData(data)
    }
}

