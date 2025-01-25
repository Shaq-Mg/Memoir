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
        VStack(alignment: .leading, spacing: 4) {
            Text(service.title)
                .font(.headline)
            Text("Price: £\(service.price)")
                .foregroundStyle(Color(.systemGray))
        }
        .font(.caption)
        .foregroundStyle(.natural)
    }
}

#Preview {
    ServiceCell(service: Preview.dev.service1)
}
