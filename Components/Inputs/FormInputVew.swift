//
//  FormInputVew.swift
//  Memoir
//
//  Created by Shaquille McGregor on 24/01/2025.
//

import SwiftUI

struct FormInputVew: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    let action: ()->()?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.callout).bold()
                .foregroundStyle(.natural)
            
            
            Button {
                action()
            } label: {
                Text(text.isEmpty ? placeholder : text)
                    .foregroundStyle(text.isEmpty ? Color(.systemGray) : .natural)
                    .autocapitalization(.none)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).fill(Color(.systemGray)))
            }
        }
    }
}

#Preview {
    FormInputVew(text: .constant(""), title: "Name", placeholder: "name", action: { })
}
