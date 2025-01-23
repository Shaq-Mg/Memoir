//
//  ClientDetailView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 28/12/2024.
//

import SwiftUI

import SwiftUI

struct ClientDetailView: View {
    @EnvironmentObject private var vm: ClientViewModel
    @Binding var showSideMenu: Bool
    @Environment(\.dismiss) private var dismiss
    let client: Client
    
    var body: some View {
        VStack {
            MainHeaderView(showSideMenu: $showSideMenu, onDismiss: true, title: client.name)
                .padding(.bottom, 24)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 18) {
                    InputDetailView(title: "Name", description: client.name)
                    InputDetailView(title: "Phone Number", description: String(client.phoneNumber))
                    InputDetailView(title: "Nickname", description: client.nickname ?? "-")
                    InputDetailView(title: "Favorite", description: client.isFavourite.description)
                }
                .padding(.horizontal)
            }
            
            Button(action: {
                vm.delete(toDelete: client)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    dismiss()
                }
            }, label: {
                Label("Delete", systemImage: "trash")
                    .font(.headline)
                    .foregroundStyle(.icon)
            })
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        ClientDetailView(showSideMenu: .constant(false), client: Preview.dev.client)
            .environmentObject(ClientViewModel())
    }
}
