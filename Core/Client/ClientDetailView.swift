//
//  ClientDetailView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 13/05/2025.
//
import SwiftUI

struct ClientDetailView: View {
    @StateObject private var vm = ClientDetailViewModel()
    @EnvironmentObject private var clientVM: ClientViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var clientDidChange = false
    @State private var showExitConfirmation = false
    @State private var client: Client
    private let originalClient: Client
    
    init(client: Client) {
        _client = State(initialValue: client)
        self.originalClient = client
    }
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 18) {
                    DetailRowView(title: "Name", placeholder: client.name, text: $client.name)
                    DetailRowView(title: "Phone Number", placeholder: String(client.phoneNumber), text: $client.phoneNumber)
                    DetailRowView(title: "Note", placeholder: client.note ?? "n/a", text: $vm.note)
                    
                    isFavouriteButton
                }
                .padding(.horizontal)
                .padding(.top, 36)
            }
            
            Button {
                Task { try await vm.delete(clientToDelete: client) }
                Task { try await clientVM.fetch() }
                dismiss()
            } label: {
                Label("Delete", systemImage: "trash")
                    .font(.headline)
                    .foregroundStyle(.accent)
            }
        }
        .navigationTitle(client.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .onAppear { Task { try await vm.load(type: client) } }
        .alert("Unsaved Changes", isPresented: $showExitConfirmation, actions: {
            Button("Stay", role: .cancel) { }
            Button("Discard Changes", role: .destructive) { dismiss() }
        }, message: {
            Text("Are you sure you want to discard unsaved changes?")
        })
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                cancelButton
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task { try await vm.update(clientToUpdate: client) }
                    Task { try await clientVM.fetch() }
                    dismiss()
                } label: {
                    Text("Done")
                        .font(.headline)
                        .foregroundStyle(Color(.label))
                }
                .disabled(!clientDidChange)
                .opacity(clientDidChange ? 1.0 : 0.5)
            }
        }
        .onChange(of: client) { oldValue, newValue in
            clientDidChange = newValue != originalClient
        }
    }
}

#Preview {
    NavigationStack {
        ClientDetailView(client: Preview.dev.client)
            .environmentObject(ClientViewModel())
    }
}

extension ClientDetailView {
    private var cancelButton: some View {
        Button {
            if clientDidChange {
                showExitConfirmation = true
            } else {
                dismiss()
            }
        } label: {
            Text("Cancel")
                .font(.headline)
                .foregroundStyle(Color(.label))
        }
    }
    
    private var isFavouriteButton: some View {
        VStack(alignment: .leading) {
            Text("Favourite?")
                .font(.callout).bold()
            
            Button {
                
            } label: {
                Text(client.isFavourite.description)
                    .foregroundStyle(Color.accentColor).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemGray6).opacity(0.45)))
            }
        }
    }
}
