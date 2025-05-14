//
//  ClientView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 13/05/2025.
//

import SwiftUI

struct ClientView: View {
    @StateObject private var manager = ClientManager()
    @State private var presentClientFormView = false
    @State private var presentFavourites = false
    @Binding var showSideMenu: Bool
    
    var body: some View {
        VStack {
            AppHeaderView(showSideMenu: $showSideMenu, title: "Clients")
            clientListHeader
            
            if manager.clients.isEmpty {
                ScrollView {
                    LoadingView(title: "Fetching clients")
                        .padding(.top, 72)
                }
            } else {
                ClientListView(presentFavourites: $presentFavourites, showSideMenu: $showSideMenu, manager: manager)
            }
        }
        .font(.title2)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            Task { try await manager.fetch() }
            Task { await manager.fetchFavouriteClients() }
        }
        .overlay(alignment: .bottomTrailing, content: {
            if !presentFavourites {
                searchSection
            }
        })
        .sheet(isPresented: $presentClientFormView, content: {
            NavigationStack {
                ClientFormView()
                    .environmentObject(manager)
                    .presentationBackgroundInteraction(.enabled(upThrough: .height(250)))
            }
        })
    }
}

#Preview {
    NavigationStack {
        ClientView(showSideMenu: .constant(false))
    }
}

extension ClientView {
    private var clientListHeader: some View {
        HStack {
            Button(action: {
                withAnimation(.spring()) {
                    Task { await manager.fetchFavouriteClients() }
                    presentFavourites.toggle()                }
            }, label: {
                Image(systemName: presentFavourites ? "heart.fill" : "heart")
                    .font(.system(size: 22))
                    .foregroundStyle(presentFavourites ? Color.accentColor : Color(.label))
            }).disabled(manager.favouriteClients.isEmpty)
            
            Spacer()
            
            Image(systemName: "chevron.down")
                .foregroundStyle(Color(.systemGray3))
                .rotationEffect(Angle(degrees: presentFavourites ? 180 : 0))
            
            Text(presentFavourites ? "Fav" : "All")
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .font(.system(size: 18, weight: .semibold))
    }
    
    private var searchSection: some View {
        HStack {
            SearchBarView(searchText: $manager.searchText)
            Button {
                presentClientFormView.toggle()
            } label: {
                HStack {
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .semibold))
                        .padding()
                }
            }
        }
        .padding(.horizontal)
    }
}
