//
//  SignUpViewModel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 11/05/2025.
//

import Foundation

final class SignUpViewModel: ObservableObject {
    @Published var email = ""
    @Published var name = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    private let authService = AuthService.shared
    
    init() {
        clearInformation()
    }
    
    private func clearInformation() {
        email = ""
        password = ""
        confirmPassword = ""
    }
    
    @MainActor
    func signUp() async throws {
        try await authService.createUser(withEmail: email, name: name, password: password)
    }
}
