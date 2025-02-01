//
//  SearchBar.swift
//  Memoir
//
//  Created by Shaquille McGregor on 28/12/2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .imageScale(.large)
                .fontWeight(.semibold)
                .padding(.leading)
            TextField("Search...", text: $searchText)
                .padding(.leading, 6)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 55)
        .background(RoundedRectangle(cornerRadius: 20).foregroundStyle(.secondary.opacity(0.06)))
    }
}

#Preview {
    SearchBar(searchText: .constant(""))
}
