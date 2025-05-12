//
//  LoginInputView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 11/05/2025.
//

import SwiftUI

struct LoginInputView: View {
    @Binding var text: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        if isSecureField {
            SecureField(placeholder, text: $text)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
        } else {
            TextField(placeholder, text: $text)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
        }
    }
}

#Preview {
    LoginInputView(text: .constant(""), placeholder: "Name")
}
