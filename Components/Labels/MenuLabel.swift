//
//  MenuLabel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 01/02/2025.
//

import SwiftUI

struct MenuLabel: View {
    @Binding var selectedOption: Page?
    let page: Page
    
    private var isSelected: Bool {
        return selectedOption == page
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: page.iconName)
                .foregroundStyle(isSelected ? .dark : .icon)
            Text(page.title)
                .foregroundStyle(isSelected ? .dark : .natural)
            Spacer()
        }
        .padding(.leading)
        .font(.system(size: 18, weight: .semibold))
        .frame(width: 216, height: 44)
        .background(isSelected ? .icon.opacity(0.8) : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    MenuLabel(selectedOption: .constant(.client), page: .client)
}
