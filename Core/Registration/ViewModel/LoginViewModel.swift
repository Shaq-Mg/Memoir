//
//  LoginViewModel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 11/05/2025.
//

import Foundation

final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    private let authService = AuthService.shared
    
    init() {
        clearInformation()
    }
    
    private func clearInformation() {
        email = ""
        password = ""
    }
    
    @MainActor
    func signIn() async throws {
        try await authService.login(withEmail: email, password: password)
    }
}
