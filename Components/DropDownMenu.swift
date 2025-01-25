//
//  DropDownMenu.swift
//  Memoir
//
//  Created by Shaquille McGregor on 24/01/2025.
//

import SwiftUI

struct DropDownMenu: View {
    @Binding var service: Service?
    let title: String
    let placeholder: String
    let action: ()->()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.callout).bold()
                .foregroundStyle(.natural)
            
            Button {
                action()
            } label: {
                Text((service == nil ? placeholder : service?.title) ?? "")
                    .foregroundStyle(service == nil ? Color(.systemGray) : .natural)
                    .autocapitalization(.none)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundStyle(.natural)
            }
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).fill(Color(.systemGray)))
        }
    }
}

#Preview {
    DropDownMenu(service: .constant(Preview.dev.service1), title: "Service", placeholder: "Description", action: { })
}
