//
//  ServiceDetailView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 29/12/2024.
//

import SwiftUI

struct ServiceDetailView: View {
    @EnvironmentObject private var vm: ServiceViewModel
    @Binding var showSideMenu: Bool
    @Environment(\.dismiss) private var dismiss
    let service: Service
    
    var body: some View {
        VStack {
            MainHeaderView(showSideMenu: $showSideMenu, onDismiss: true, title: service.title)
            List {
                Section("General") {
                    HStack(spacing: 10) {
                        Circle()
                            .frame(width: 33, height: 33)
                            .foregroundStyle(.secondary)
                            .overlay {
                                Text((service.title.prefix(1).capitalized))
                                    .font(.title3.bold())
                                    .foregroundStyle(.white)
                            }
                        
                        Text(service.title)
                            .font(.title2.bold())
                    }
                    .padding(.vertical, 8)
                    DetailView(title: "Price", description: String(service.price))
                    DetailView(title: "Duration", description: String(service.duration))
                }
                .fontWeight(.semibold)
            }
            .listStyle(.plain)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ServiceDetailView(showSideMenu: .constant(false), service: Preview.dev.service)
            .environmentObject(ServiceViewModel())
    }
}
