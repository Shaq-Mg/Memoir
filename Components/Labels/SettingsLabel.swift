//
//  SettingsLabel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 02/02/2025.
//

import SwiftUI

struct SettingsLabel: View {
    let title: String
    let imageName: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: imageName)
                .foregroundStyle(.icon)
            Text(title)
                .foregroundStyle(.natural)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color(.systemGray4))
        }
        .font(.system(size: 20, weight: .semibold))
        .padding(.vertical, 10)
    }
}

#Preview {
    SettingsLabel(title: "Notifications", imageName: "bell.badge")
}
