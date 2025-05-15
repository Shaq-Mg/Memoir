//
//  LoginView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 11/05/2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var formIsValid = true
    
    var body: some View {
        VStack {
            LoginInputView(text: $viewModel.email, placeholder: "Email")
            LoginInputView(text: $viewModel.password, placeholder: "Password", isSecureField: true)
            
            Button {
                
            } label: {
                Text("Forgot Password?")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundStyle(Color(.label))
                    .fontWeight(.semibold)
                    .padding()
            }
            
            Button("Sign In") {
                Task { try await viewModel.signIn() }
            }
            .foregroundStyle(Color("AppBackground"))
            .fontWeight(.semibold)
            .padding()
            .frame(maxWidth: .infinity)
            .disabled(!formIsValid)
            .background(Color(.label).opacity(formIsValid ? 1.0 : 0.4))
            .cornerRadius(8)
            .padding(.vertical)
            
            NavigationLink {
                SignUpView()
            } label: {
                Text("Dont have a existing accont?")
                Text("Sign up").bold()
            }
            .foregroundStyle(.black)
            
        }
        .padding()
        .navigationTitle("Sign In")
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
