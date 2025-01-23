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
                .padding(.bottom, 24)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 18) {
                    InputDetailView(title: "Title", description: service.title)
                    InputDetailView(title: "Price", description: "£" + String(service.price))
                    InputDetailView(title: "Duration", description: String(service.duration))
                }
                .padding(.horizontal)
            }
            
            Button(action: {
                vm.delete(toDelete: service)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    dismiss()
                }
            }, label: {
                Label("Delete", systemImage: "trash")
                    .font(.headline)
                    .foregroundStyle(.icon)
            })
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
