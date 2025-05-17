//
//  ServiceCellView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 15/05/2025.
//

import SwiftUI

struct ServiceCellView: View {
    let service: Service
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(service.title)
                    .font(.body) .fontWeight(.semibold)
                    .foregroundStyle(Color(.label))
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.footnote) .fontWeight(.semibold)
                    .foregroundStyle(Color(.systemGray))
            }
        }
    }
}

#Preview {
    ServiceCellView(service: Preview.dev.service1)
}
