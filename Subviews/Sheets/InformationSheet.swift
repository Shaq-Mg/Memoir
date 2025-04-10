//
//  InformationSheet.swift
//  Memoir
//
//  Created by Shaquille McGregor on 02/02/2025.
//

import SwiftUI

struct InformationSheet: View {
    let option: SettingsOption
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ScrollView {
                Text(option.description)
                    .font(.subheadline)
                    .foregroundStyle(Color(.systemGray))
                    .padding(.top, 36)
            }
        }
        .bold()
        .navigationTitle(option.title)
        .padding(.horizontal, 12)
    }
}

#Preview {
    InformationSheet(option: .privacy)
}
