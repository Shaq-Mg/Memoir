//
//  MenuLabelView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 23/06/2025.
//

import SwiftUI

struct MenuLabelView: View {
    @Binding var selectedOption: Page?
    let page: Page
    
    private var isSelected: Bool {
        return selectedOption == page
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: page.iconName)
                
            Text(page.title)
            Spacer()
        }
        .padding(.leading)
        .foregroundStyle(isSelected ? .white : .accent)
        .font(.headline)
        .frame(width: 216, height: 44)
        .background(isSelected ? .accent.opacity(0.8) : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    MenuLabelView(selectedOption: .constant(.client), page: .client)
}
