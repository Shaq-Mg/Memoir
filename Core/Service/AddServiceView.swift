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
            CreateInputView(text: $viewModel.title, title: "Title", placeholder: "Title")
                .padding(.top)
            CreateInputView(text: $viewModel.price, title: "Price", placeholder: "Amount", isDecimal: true)
            CreateInputView(text: $viewModel.durationValue, title: "Duration", placeholder: "Minutes", isDecimal: true)
            
            Button {
                if !viewModel.title.isEmpty && !viewModel.price.isEmpty {
                    viewModel.add(title: viewModel.title, price: viewModel.price)
                    dismiss()
                }
            } label: {
                Text("Save".uppercased())
            }
            .font(.headline)
            .foregroundStyle(Color.dark)
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(Color("icon"))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 4)
            .padding([.top, .bottom], 36)
            
            Spacer()
        }
        .navigationTitle("Add Service")
        .navigationBarTitleDisplayMode(.inline)
        .fontWeight(.semibold)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
        .presentationDetents([.height(400)])
        .onAppear(perform: viewModel.clearServiceInformation)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                cancelButton
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddServiceView()
            .environmentObject(ServiceViewModel())
    }
}

private extension AddServiceView {
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
