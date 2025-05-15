//
//  ServiceDetailView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 15/05/2025.
//

import SwiftUI

struct EditServiceView: View {
    @StateObject private var editVM = EditServiceViewModel()
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
                    .foregroundStyle(.accent)
            })
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        EditServiceView(showSideMenu: .constant(false), service: Preview.dev.service1)
            .environmentObject(ServiceViewModel())
    }
}

