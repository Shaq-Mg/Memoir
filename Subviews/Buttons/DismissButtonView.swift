//
//  DismissButtonView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 21/06/2025.
//

import SwiftUI

struct DismissButtonView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .foregroundStyle(Color(.systemGray))
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    DismissButtonView()
}
