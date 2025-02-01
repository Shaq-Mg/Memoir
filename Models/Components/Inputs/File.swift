//
//  File.swift
//  Memoir
//
//  Created by Shaquille McGregor on 24/01/2025.
//


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