//
//  BookedRowView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 17/05/2025.
//

import SwiftUI

struct BookedRowView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.callout).bold()
                .foregroundStyle(Color(.darkGray))
            
            Text(description)
                .foregroundStyle(Color(.label))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).fill(Color(.systemGray)))
        }
    }
}

#Preview {
    BookedRowView(title: "Description", description: "Haircut")
}
