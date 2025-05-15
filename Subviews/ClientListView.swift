//
//  ClientListView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 13/05/2025.
//

import SwiftUI

struct ClientListView: View {
    @EnvironmentObject private var vm: ClientViewModel
    @Binding var presentFavourites: Bool
    @Binding var showSideMenu: Bool
    
    var body: some View {
        ZStack {
            if presentFavourites {
                List {
                    ForEach(vm.favouriteClients) { client in
                        ZStack {
                            NavigationLink {
                                ClientDetailView(showSideMenu: $showSideMenu, client: client)
                                    .environmentObject(vm)
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
                    ForEach(!vm.searchText.isEmpty ? vm.filteredClients : vm.clients) { client in
                        ZStack {
                            NavigationLink {
                                ClientDetailView(showSideMenu: $showSideMenu, client: client)
                                    .environmentObject(vm)
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
    ClientListView(presentFavourites: .constant(false), showSideMenu: .constant(false))
        .environmentObject(ClientViewModel())
}
