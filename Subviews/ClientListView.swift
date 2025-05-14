//
//  ClientListView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 13/05/2025.
//

import SwiftUI

struct ClientListView: View {
    @Binding var presentFavourites: Bool
    @Binding var showSideMenu: Bool
    var manager: ClientManager
    
    var body: some View {
        ZStack {
            if presentFavourites {
                List {
                    ForEach(manager.favouriteClients) { client in
                        ZStack {
                            NavigationLink {
                                ClientDetailView(showSideMenu: $showSideMenu, client: client)
                                    .environmentObject(manager)
                            } label: {
                                EmptyView()
                            }.opacity(0)
                            ClientCellView(client: client)
                        }
                    }
                }
                .listStyle(.plain)
            } else {
                List {
                    ForEach(!manager.searchText.isEmpty ? manager.filteredClients : manager.clients) { client in
                        ZStack {
                            NavigationLink {
                                ClientDetailView(showSideMenu: $showSideMenu, client: client)
                                    .environmentObject(manager)
                            } label: {
                                EmptyView()
                            }.opacity(0)
                            ClientCellView(client: client)
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
    }
}

#Preview {
    let manager = ClientManager()
    ClientListView(presentFavourites: .constant(false), showSideMenu: .constant(false), manager: manager)
}
