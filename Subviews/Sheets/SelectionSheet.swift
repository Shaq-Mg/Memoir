//
//  SelectionSheet.swift
//  Memoir
//
//  Created by Shaquille McGregor on 24/01/2025.
//

import SwiftUI

struct SelectionSheet<S: CustomStringConvertible & Identifiable & Equatable>: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selection: S?
    let items: [S]
    
    var body: some View {
        List(items) { item in

            HStack {
                Button {
                    selection = item
                    dismiss()
                } label: {
                    Text(item.description)
                }
                
                Spacer()
                if selection == item {
                    Image(systemName: "checkmark")
                        .font(.headline)
                }
            }
            .foregroundStyle(.natural)
            .contentShape(.rect)
        }
        .navigationTitle("Select")
        .navigationBarTitleDisplayMode(.inline)
        .presentationDetents([.height(300)])
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(Color(.darkGray))
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SelectionSheet(selection: .constant(Preview.dev.service1), items: [Preview.dev.service1, Preview.dev.service2])
    }
}
