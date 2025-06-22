//
//  InputDetailView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 15/06/2025.
//

import SwiftUI

struct InputDetailView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.callout).bold()
            Text(description)
                .frame(maxWidth: .infinity, alignment: .leading)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemGray6).opacity(0.45)))
        }
    }
}

#Preview {
    InputDetailView(title: "Haircut", description: "20mins")
}
