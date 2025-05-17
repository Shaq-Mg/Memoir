//
//  EditServiceView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 15/05/2025.
//

import SwiftUI

struct EditServiceView: View {
    @StateObject private var editVM = EditServiceViewModel()
    @EnvironmentObject private var vm: ServiceViewModel
    @Environment(\.dismiss) private var dismiss
    let service: Service
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 18) {
                    DetailRowView(title: "Title", placeholder: service.title, text: $editVM.title)
                    DetailRowView(title: "Price", placeholder: "£\(service.price)", text: $editVM.price)
                        .keyboardType(.numberPad)
                }
                .padding(.horizontal)
                .padding(.top, 44)
            }
            
            Button(action: {
                Task { try await editVM.delete(for: service) }
                Task { try await vm.fetchServices() }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    dismiss()
                }
            }, label: {
                Label("Delete", systemImage: "trash")
                    .font(.headline)
                    .foregroundStyle(.accent)
            })
        }
        .navigationTitle("Edit Service")
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                CancelButtonView(fontSize: .headline, fontColor: Color(.darkGray))
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task { try await editVM.update(for: service) }
                    Task { try await vm.fetchServices() }
                    dismiss()
                } label: {
                    Text("Done")
                        .font(.headline)
                        .foregroundStyle(Color(.darkGray))
                }
                .disabled(!editVM.isValid)
                .opacity(editVM.isValid ? 1.0 : 0.4)
            }
        }
    }
}

#Preview {
    NavigationStack {
        EditServiceView(service: Preview.dev.service1)
            .environmentObject(EditServiceViewModel())
    }
}

