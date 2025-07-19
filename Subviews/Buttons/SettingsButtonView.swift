//
//  SettingsButtonView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 22/06/2025.
//

import SwiftUI

struct SettingsButtonView: View {
    let title: String
    let imageName: String
    let action: ()->()?
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(alignment: .center, spacing: 12) {
                Image(systemName: imageName)
                    .foregroundStyle(.accent)
                Text(title)
            }
            .font(.headline)
            .padding(.vertical, 10)
            .foregroundStyle(Color(.label))
        }
    }
}

#Preview {
    SettingsButtonView(title: "Email", imageName: "envelope", action: { })
}
