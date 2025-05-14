//
//  ClientCellView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 13/05/2025.
//

import SwiftUI

struct ClientCellView: View {
    let client: Client
    
    var body: some View {
        HStack {
            Circle()
                .frame(width: 28, height: 28)
                .foregroundStyle(.secondary)
                .overlay {
                    Text((client.name.prefix(1).capitalized))
                        .font(.system(size: 16, design: .rounded).bold())
                        .foregroundStyle(.white)
                }
            VStack(alignment: .leading, spacing: 6) {
                Text(client.name)
                    .font(.system(size: 18, design: .rounded).bold())
            }
            Spacer()
            if client.isFavourite {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundStyle(.indigo)
                    .font(.system(size: 14))
            }
        }
    }
}

#Preview {
    ClientCellView(client: Preview.dev.client)
}
