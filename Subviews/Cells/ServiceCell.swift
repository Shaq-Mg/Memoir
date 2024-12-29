//
//  ServiceCell.swift
//  Memoir
//
//  Created by Shaquille McGregor on 29/12/2024.
//

import SwiftUI

struct ServiceCell: View {
    let service: Service
    
    var body: some View {
        HStack {
            Text(service.title)
                .font(.headline)
            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                Text("Price: £\(service.price)")
                    .foregroundStyle(.black)
                Text("\(service.duration) mins")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ServiceCell(service: Preview.dev.service)
}
