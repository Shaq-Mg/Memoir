//
//  DetailView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 28/12/2024.
//

import SwiftUI

struct DetailView: View {
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
                .background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemGray6).opacity(0.75)))
        }
    }
}

#Preview {
    DetailView(title: "Haircut", description: "20mins")
}
