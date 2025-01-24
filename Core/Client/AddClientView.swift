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
            CreateInputView(text: $viewModel.name, title: "Name", placeholder: "Name")
                .padding(.top)
            CreateInputView(text: $viewModel.phoneNumber, title: "Phone number", placeholder: "Phone number")
            CreateInputView(text: $viewModel.nickname, title: "Nickname", placeholder: "Nickname")
            Toggle("Favourite", isOn: $viewModel.isFavourite)
                .tint(Color.icon)
            
            Button {
                if !viewModel.name.isEmpty && !viewModel.phoneNumber.isEmpty {
                    viewModel.create(name: viewModel.name, phoneNumber: viewModel.phoneNumber, nickname: viewModel.nickname, isFavourite: viewModel.isFavourite)
                    dismiss()
                }
            } label: {
                Text("Save".uppercased())
                    .font(.headline)
                    .foregroundStyle(Color.dark)
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(Color("icon"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 4)
                    .padding(.top, 44)
            }
            Spacer()
        }
        .navigationTitle("Add Client")
        .navigationBarTitleDisplayMode(.inline)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .presentationDetents([.height(400)])
        .padding(.horizontal)
        .onAppear(perform: viewModel.clearInformation)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                cancelButton
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddClientView()
            .environmentObject(ClientViewModel())
    }
}

extension AddClientView {
    private var cancelButton: some View {
        Button {
            dismiss()
        } label: {
            Text("Cancel")
                .foregroundStyle(.gray)
        }
        .font(.headline)
    }
}
