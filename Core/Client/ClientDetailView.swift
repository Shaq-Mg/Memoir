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
            List {
                Section("Information") {
                    DetailView(title: "Phone number", description: client.phoneNumber)
                    DetailView(title: "Nickname", description: client.nickname ?? "")
                    DetailView(title: "Favourite", description: client.isFavourite.description)
                }
            }
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
