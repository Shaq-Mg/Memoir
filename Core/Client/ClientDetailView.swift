//
//  ClientDetailView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 13/05/2025.
//
import SwiftUI

struct ClientDetailView: View {
    @EnvironmentObject private var manager: ClientManager
    @Environment(\.dismiss) private var dismiss
    @Binding var showSideMenu: Bool
    let client: Client
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 18) {
                    DetailRowView(title: "Name", placeholder: client.name, text: $manager.name)
                    DetailRowView(title: "Phone Number", placeholder: String(client.phoneNumber), text: $manager.phoneNumber)
                    DetailRowView(title: "Note", placeholder: client.note ?? "", text: $manager.note)
                    
                    isFavouriteButton
                }
                .padding(.horizontal)
                .padding(.top, 36)
            }
            
            Button(action: {
                Task { try await manager.delete(clientToDelete: client) }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    dismiss()
                }
            }, label: {
                Label("Delete", systemImage: "trash")
                    .font(.headline)
                    .foregroundStyle(.accent)
            })
        }
        .navigationTitle(client.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            manager.clearFormInformation()
            Task { try await manager.load(type: client) }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                CancelButtonView(fontSize: .headline, fontColor: Color(.darkGray))
                    .foregroundStyle(Color(.label))
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    if !manager.name.isEmpty && !manager.phoneNumber.isEmpty {
                        Task { try await manager.update(clientToUpdate: client) }
                    }
                    dismiss()
                } label: {
                    Text("Done")
                        .font(.headline)
                        .foregroundStyle(Color(.label))
                }.disabled(manager.name.isEmpty && manager.phoneNumber.isEmpty)
                    .opacity(manager.name.isEmpty && manager.phoneNumber.isEmpty ? 0.2 : 1.0)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ClientDetailView(showSideMenu: .constant(false), client: Preview.dev.client)
            .environmentObject(ClientManager())
    }
}

extension ClientDetailView {
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
