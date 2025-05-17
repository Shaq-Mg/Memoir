//
//  FormInputView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 16/05/2025.
//

import SwiftUI

struct FormInputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    let action: ()->()?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.callout).bold()
                .foregroundStyle(Color(.darkGray))
            
            
            Button {
                action()
            } label: {
                Text(text.isEmpty ? placeholder : text)
                    .foregroundStyle(text.isEmpty ? Color(.systemGray) : Color(.darkGray))
                    .autocapitalization(.none)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5).fill(Color(.systemGray)))
            }
        }
    }
}

#Preview {
    FormInputView(text: .constant(""), title: "Name", placeholder: "name") { }
}
