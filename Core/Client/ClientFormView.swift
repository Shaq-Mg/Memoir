//
//  ClientFormView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 13/05/2025.
//

import SwiftUI

struct ClientFormView: View {
    @StateObject private var vm = ClientFormViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 18) {
                InputView(text: $vm.name, title: "Name", placeholder: "Name")
                    .padding(.top)
                InputView(text: $vm.phoneNumber, title: "Phone number", placeholder: "Phone number")
                InputView(text: $vm.note, title: "Note", placeholder: "Note", isNote: true)
                Toggle("Favourite", isOn: $vm.isFavourite)
                    .tint(Color.accent)
            }
        }
        .navigationTitle("Add Client")
        .navigationBarTitleDisplayMode(.inline)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .presentationDetents([.height(400)])
        .padding(.horizontal)
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
    }
}

extension ClientFormView {
    private var saveButton: some View {
        Button {
            if !vm.name.isEmpty && !vm.phoneNumber.isEmpty {
                Task { try await vm.save() }
                dismiss()
            }
        } label: {
            Text("Save")
                .foregroundStyle(Color(.label))
        }
        .font(.headline)
        .opacity(!vm.name.isEmpty && !vm.phoneNumber.isEmpty ? 1.0 : 0.2)
        .disabled(vm.name.isEmpty && vm.phoneNumber.isEmpty)
    }
}
