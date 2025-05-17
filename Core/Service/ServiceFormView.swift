//
//  ServiceFormView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 15/05/2025.
//

import SwiftUI

struct ServiceFormView: View {
    @StateObject private var vm = ServiceFormViewModel()
    @EnvironmentObject private var serviceVM: ServiceViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 18) {
                    InputView(text: $vm.title, title: "Title", placeholder: "Title")
                    InputView(text: $vm.price, title: "Price", placeholder: "Price")
                        .keyboardType(.numberPad)
                }
                .padding(.horizontal)
                .padding(.top, 44)
            }
        }
        .navigationTitle("Edit Service")
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .presentationDetents([.height(400)])
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                CancelButtonView(fontSize: .headline, fontColor: Color(.darkGray))
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task { try await vm.save() }
                    Task { try await serviceVM.fetchServices() }
                    dismiss()
                } label: {
                    Text("Save")
                        .font(.headline)
                        .foregroundStyle(Color(.darkGray))
                }
                .disabled(!vm.isFormValid)
                .opacity(vm.isFormValid ? 1.0 : 0.4)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ServiceFormView()
            .environmentObject(ServiceFormViewModel())
    }
}
