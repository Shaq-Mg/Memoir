//
//  CancelButtonView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 13/05/2025.
//

import SwiftUI

struct CancelButtonView: View {
    @Environment(\.dismiss) private var dismiss
    let fontSize: Font
    let fontColor: Color
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Text("Cancel")
                .foregroundStyle(fontColor)
                .font(fontSize)
        }
    }
}

#Preview {
    CancelButtonView(fontSize: .footnote, fontColor: Color(.label))
}
