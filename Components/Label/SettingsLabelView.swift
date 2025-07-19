//
//  SettingsLabelView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 22/06/2025.
//

import SwiftUI

struct SettingsLabelView: View {
    let title: String
    let imageName: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: imageName)
                .foregroundStyle(.accent)
            Text(title)
                .foregroundStyle(Color(.label))
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(Color(.systemGray4))
        }
        .font(.headline)
        .padding(.vertical, 10)
    }
}

#Preview {
    SettingsLabelView(title: "Notifications", imageName: "bell.badge")
}
