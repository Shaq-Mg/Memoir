//
//  FormIsValid.swift
//  Memoir
//
//  Created by Shaquille McGregor on 27/12/2024.
//

import Foundation

extension LoginView {
    var formIsValid: Bool {
        return !authViewModel.email.isEmpty
        && authViewModel.email.contains("@")
        && !authViewModel.password.isEmpty
        && authViewModel.password.count >= 5
    }
}

extension SignUpView {
    var formIsValid: Bool {
        return !authViewModel.email.isEmpty
        && authViewModel.email.contains("@")
        && !authViewModel.password.isEmpty
        && authViewModel.password.count >= 5
        && authViewModel.confirmPassword == authViewModel.password
    }
}
