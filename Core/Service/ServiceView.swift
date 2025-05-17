//
//  ServiceView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 15/05/2025.
//

import SwiftUI

struct ServiceView: View {
    @StateObject private var viewModel = ServiceViewModel()
    @State private var presentFormView = false
    @State private var selectedService: Service?
    @Binding var showSideMenu: Bool
    
    var body: some View {
        VStack {
            MenuHeaderView(showSideMenu: $showSideMenu, title: "Services")
                .padding(.bottom, 24)
            
            if viewModel.filteredServices.isEmpty {
                Spacer()
                LoadingView(title: "Fetching services")
                Spacer()
            } else {
                List {
                    ForEach(viewModel.filteredServices) { service in
                        Button {
                            selectedService = service
                        } label: {
                            ServiceCellView(service: service)
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationDestination(item: $selectedService) { service in
            NavigationStack {
                EditServiceView(service: service)
                    .environmentObject(viewModel)
            }
        }
        .overlay(alignment: .bottomTrailing, content: {
            searchSection
        })
    }
}

#Preview {
    NavigationStack {
        ServiceView(showSideMenu: .constant(false))
            .environmentObject(ServiceViewModel())
    }
}

extension ServiceView {
    private var searchSection: some View {
        HStack {
            SearchBarView(searchText: $viewModel.searchText)
            Button {
                presentFormView.toggle()
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 24, weight: .semibold))
                    .padding()
            }
        }
        .padding(.horizontal)
        .sheet(isPresented: $presentFormView) {
            NavigationStack {
                ServiceFormView()
                    .environmentObject(viewModel)
            }
        }
    }
}
