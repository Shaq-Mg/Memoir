//
//  AddClientView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 28/12/2024.
//

import SwiftUI

struct AddClientView: View {
    @EnvironmentObject private var viewModel: ClientViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 18) {
            addClientHeader
            
            Text("Add Client")
                .font(.system(size: 32, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 32)
            
            CreateTextfield(text: $viewModel.name, title: "Name", placeholder: "Name")
            CreateTextfield(text: $viewModel.phoneNumber, title: "Phone number", placeholder: "Phone number")
            CreateTextfield(text: $viewModel.nickname, title: "Nickname", placeholder: "Nickname")
            Toggle("Favourite", isOn: $viewModel.isFavourite)
                .tint(Color.icon)
            
            Button {
                if !viewModel.name.isEmpty && !viewModel.phoneNumber.isEmpty {
                    viewModel.create(name: viewModel.name, phoneNumber: viewModel.phoneNumber, nickname: viewModel.nickname, isFavourite: viewModel.isFavourite)
                    dismiss()
                }
            } label: {
                Text("Add")
                    .font(.headline)
                    .foregroundStyle(Color.dark)
                    .padding(12)
                    .frame(maxWidth: .infinity)
                    .background(Color("icon"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 4)
                    .padding(.top, 44)
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        AddClientView()
            .environmentObject(ClientViewModel())
    }
}

extension AddClientView {
    private var addClientHeader: some View {
        HStack(alignment: .top) {
            Button {
                dismiss()
            } label: {
                Text("Cancel")
                    .foregroundStyle(.gray)
            }
            Spacer()
            ReusableCapsule()
            Spacer()
            Text("      ")
            
        }
        .font(.headline)
        .padding(.vertical, 16)
    }
}
