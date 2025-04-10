//
//  SettingsButton.swift
//  Memoir
//
//  Created by Shaquille McGregor on 02/02/2025.
//

import SwiftUI

struct SettingsButton: View {
    let title: String
    let imageName: String
    let action: ()->()?
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(alignment: .center, spacing: 12) {
                Image(systemName: imageName)
                    .foregroundStyle(.icon)
                Text(title)
            }
            .font(.system(size: 20, weight: .semibold))
            .padding(.vertical, 10)
            .foregroundStyle(.natural)
        }
    }
}

#Preview {
    SettingsButton(title: "Email", imageName: "envelope", action: { })
}
