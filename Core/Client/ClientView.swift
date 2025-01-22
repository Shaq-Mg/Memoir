//
//  ClientView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 28/12/2024.
//

import SwiftUI

struct ClientView: View {
    @EnvironmentObject var clientVM: ClientViewModel
    @State private var isShowNewClient = false
    @Binding var showSideMenu: Bool
    
    var body: some View {
        VStack {
            MainHeaderView(showSideMenu: $showSideMenu, title: "Clients")
            clientListHeader
            
            ZStack {
                clientListsView
                
                if clientVM.clients.isEmpty {
                    Text("No clients available")
                } else {
                    EmptyView()
                }
            }
        }
        .onAppear(perform: clientVM.fetchClientsWithListener)
        .font(.title2)
        .navigationBarBackButtonHidden(true)
        .overlay(alignment: .bottomTrailing, content: {
            HStack {
                SearchBarView(searchText: $clientVM.searchText)
                Button {
                    isShowNewClient.toggle()
                    if clientVM.isFavourite == false {
                        clientVM.fetchFavouriteClients()
                    }
                } label: {
                    HStack {
                        AddButton()
                            .padding()
                    }
                }
            }
            .padding(.horizontal)
        })
        .sheet(isPresented: $isShowNewClient, content: {
            NavigationStack {
                AddClientView()
            }
            .environmentObject(clientVM)
        })
    }
}

#Preview {
    NavigationStack {
        ClientView(showSideMenu: .constant(false))
            .environmentObject(ClientViewModel())
    }
}

extension ClientView {
    private var clientListHeader: some View {
        HStack {
            Button(action: {
                withAnimation(.spring()) {
                    clientVM.isFavourite.toggle()
                }
            }, label: {
                Image(systemName: clientVM.isFavourite ? "heart.fill" : "heart")
                    .font(.system(size: 22))
                    .foregroundStyle(clientVM.isFavourite ? Color.icon : .black)
            })
            
            Spacer()
            
            Image(systemName: "chevron.down")
                .foregroundStyle(Color("icon"))
                .rotationEffect(Angle(degrees: clientVM.isFavourite ? 180 : 0))
            
            Text(clientVM.isFavourite ? "Favourites" : "All")
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .font(.system(size: 18, weight: .semibold))
    }
    
    private var clientListsView: some View {
        VStack {
            if clientVM.isFavourite {
                List(clientVM.favouriteClients) { client in
                    ZStack {
                        NavigationLink(destination: ClientDetailView(showSideMenu: $showSideMenu, client: client)) {
                            EmptyView()
                        }
                        .environmentObject(clientVM)
                        .opacity(0)
                        ClientCell(client: client)
                    }
                }
                .listStyle(.plain)
            } else {
                List {
                    ForEach(clientVM.filteredClients) { client in
                        ZStack {
                            NavigationLink(destination: ClientDetailView(showSideMenu: $showSideMenu, client: client)) {
                                EmptyView()
                            }
                            .environmentObject(clientVM)
                            .opacity(0)
                            ClientCell(client: client)
                        }
                    }
                    .onDelete(perform: clientVM.delete)
                }
                .listStyle(.plain)
            }
        }
    }
}
