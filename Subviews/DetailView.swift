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
        HStack(spacing: 10) {
            Text(title.uppercased() + ":")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text(description)
                .fontWeight(.semibold)
        }
    }}

#Preview {
    DetailView(title: "Haircut", description: "20mins")
}
