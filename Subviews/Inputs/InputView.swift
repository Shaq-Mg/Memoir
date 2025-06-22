//
//  InputView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 11/05/2025.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isDecimal = false
    var isNote = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if isDecimal {
                Text(title)
                    .font(.footnote)
                    .fontWeight(.semibold)
                TextField(placeholder, text: $text)
                    .keyboardType(.decimalPad)
                Divider()
            } else if isNote {
                Text(title)
                    .font(.footnote)
                    .fontWeight(.semibold)
                TextField(placeholder, text: $text, axis: .vertical)
                Divider()
            } else {
                Text(title)
                    .font(.footnote)
                    .fontWeight(.semibold)
                TextField(placeholder, text: $text)
            }
        }
        .font(.body)
    }
}

#Preview {
    InputView(text: .constant(""), title: "Email", placeholder: "kobe@gmail.com")
}
