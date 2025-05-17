//
//  SelectionSheet.swift
//  Memoir
//
//  Created by Shaquille McGregor on 17/05/2025.
//

import SwiftUI

struct SelectionSheet<S: FirebaseModel>: View {
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
            .foregroundStyle(Color(.label))
            .contentShape(.rect)
        }
        .navigationTitle("Select")
        .navigationBarTitleDisplayMode(.inline)
        .presentationDetents([.fraction(0.3)])
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
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
