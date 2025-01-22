//
//  ServiceView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 29/12/2024.
//

import SwiftUI

struct ServiceView: View {
    @EnvironmentObject private var viewModel: ServiceViewModel
    @State private var showAddServiceView = false
    @Binding var showSideMenu: Bool
    
    var body: some View {
        VStack {
            MainHeaderView(showSideMenu: $showSideMenu, title: "Services")
            Spacer()
            if viewModel.filteredServices.isEmpty {
                Text("No services available")
                    .font(.title2)
                Spacer()
            } else {
                List {
                    ForEach(viewModel.filteredServices) { service in
                        ZStack {
                            NavigationLink(destination: ServiceDetailView(showSideMenu: $showSideMenu, service: service)) {
                                EmptyView()
                            }
                            .opacity(0)

                            ServiceCell(service: service)
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .onAppear { viewModel.fetchServicesWithListener() }
        .sheet(isPresented: $showAddServiceView) {
            NavigationStack {
                AddServiceView()
            }
        }
        .overlay(alignment: .bottomTrailing, content: {
            HStack {
                SearchBarView(searchText: $viewModel.searchText)
                Button {
                    showAddServiceView.toggle()
                } label: {
                    AddButton()
                }
            }
            .padding(.horizontal)
        })
    }
}

#Preview {
    NavigationStack {
        ServiceView(showSideMenu: .constant(false))
            .environmentObject(ServiceViewModel())
    }
}

