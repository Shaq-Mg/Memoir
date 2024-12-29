//
//  CreateTextfield.swift
//  Memoir
//
//  Created by Shaquille McGregor on 28/12/2024.
//

import SwiftUI

struct CreateTextfield: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isDecimal = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if isDecimal {
                Text(title)
                    .font(.caption)
                TextField(placeholder, text: $text)
                    .keyboardType(.decimalPad)
                Divider()
            } else {
                Text(title)
                    .font(.caption)
                TextField(placeholder, text: $text)
                Divider()
            }
        }
    }
}

#Preview {
    CreateTextfield(text: .constant(""), title: "Phone number", placeholder: "")
}
