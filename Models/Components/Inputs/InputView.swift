//
//  InputView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 27/12/2024.
//

import SwiftUI

struct InputView: View {
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
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
        }
    }
}

#Preview {
    InputView(text: .constant("Email"), placeholder: "Email")
}
