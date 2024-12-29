//
//  AddServiceView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 29/12/2024.
//

import SwiftUI

struct AddServiceView: View {
    @EnvironmentObject private var viewModel: ServiceViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 18) {
            addServiceHeader
            
            Text("Add Service")
                .font(.system(size: 32, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 32)
            
            CreateTextfield(text: $viewModel.title, title: "Title", placeholder: "Title")
            CreateTextfield(text: $viewModel.price, title: "Price", placeholder: "Amount", isDecimal: true)
            CreateTextfield(text: $viewModel.duration, title: "Duration", placeholder: "Minutes", isDecimal: true)
            
            Button {
                if !viewModel.title.isEmpty && !viewModel.price.isEmpty {
                    viewModel.add(title: viewModel.title, price: viewModel.price, duration: viewModel.duration)
                    dismiss()
                }
            } label: {
                Text("Save".uppercased())
            }
            .font(.headline)
            .foregroundStyle(Color.dark)
            .padding(12)
            .frame(maxWidth: .infinity)
            .background(Color("icon"))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 4)
            .padding(.top, 44)
            
            Spacer()
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
        .fontWeight(.semibold)
    }
}

#Preview {
    NavigationStack {
        AddServiceView()
            .environmentObject(ServiceViewModel())
    }
}

extension AddServiceView {
    private var addServiceHeader: some View {
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

