//
//  DetailRowView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 13/05/2025.
//

import SwiftUI

struct DetailRowView: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.footnote).bold()
            TextField(placeholder, text: $text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemGray6).opacity(0.45)))
        }
    }
}

#Preview {
    DetailRowView(title: "Haircut", placeholder: "20mins", text: .constant(""))
}
