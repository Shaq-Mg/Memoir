//
//  SignUpView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 11/05/2025.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    @State private var formIsValid = true
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            LoginInputView(text: $viewModel.name, placeholder: "Name")
            LoginInputView(text: $viewModel.email, placeholder: "Email")
            LoginInputView(text: $viewModel.password, placeholder: "Password", isSecureField: true)
            LoginInputView(text: $viewModel.confirmPassword, placeholder: "Confirm password", isSecureField: true)
            
            Button("Create account") {
                Task { try await viewModel.signUp() }
            }
            .foregroundStyle(Color("AppBackground"))
            .fontWeight(.semibold)
            .padding()
            .frame(maxWidth: .infinity)
            .disabled(!formIsValid)
            .background(Color(.label).opacity(formIsValid ? 1.0 : 0.4))
            .cornerRadius(8)
            .padding(.vertical)
            
            Button {
                dismiss()
            } label: {
                Text("Already have an existing accont?")
                Text("Sign in").bold()
            }
            .foregroundStyle(Color(.label))
        }
        .padding()
        .navigationTitle("Create account")
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        SignUpView()
    }
}
