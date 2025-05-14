//
//  ClientFormView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 13/05/2025.
//

import SwiftUI

struct ClientFormView: View {
    @EnvironmentObject private var manager: ClientManager
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 18) {
                InputView(text: $manager.name, title: "Name", placeholder: "Name")
                    .padding(.top)
                InputView(text: $manager.phoneNumber, title: "Phone number", placeholder: "Phone number")
                InputView(text: $manager.note, title: "Note", placeholder: "Note", isNote: true)
                Toggle("Favourite", isOn: $manager.isFavourite)
                    .tint(Color.accent)
            }
        }
        .navigationTitle("Add Client")
        .navigationBarTitleDisplayMode(.inline)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .presentationDetents([.height(400)])
        .padding(.horizontal)
        .onAppear { manager.clearFormInformation() }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                CancelButtonView(fontSize: .headline, fontColor: Color(.darkGray))
                    .foregroundStyle(Color(.label))
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                saveButton
            }
        }
    }
}

#Preview {
    NavigationStack {
        ClientFormView()
            .environmentObject(ClientManager())
    }
}

extension ClientFormView {
    private var saveButton: some View {
        Button {
            if !manager.name.isEmpty && !manager.phoneNumber.isEmpty {
                Task { try await manager.save() }
                dismiss()
            }
        } label: {
            Text("Save")
                .foregroundStyle(Color(.label))
        }
        .font(.headline)
        .opacity(!manager.name.isEmpty && !manager.phoneNumber.isEmpty ? 1.0 : 0.2)
        .disabled(manager.name.isEmpty && manager.phoneNumber.isEmpty)
    }
}
