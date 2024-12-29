//
//  LoginView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 27/12/2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            InputView(text: $authViewModel.email, placeholder: "Email")
            InputView(text: $authViewModel.password, placeholder: "Password", isSecureField: true)
            
            Text(authViewModel.errorMessage)
                .foregroundStyle(.red)
                .padding()
            
            Button("Sign In") {
                Task {
                    try await authViewModel.signIn(withEmail: authViewModel.email, password: authViewModel.password)
                }
            }
            .foregroundStyle(Color("dark"))
            .fontWeight(.semibold)
            .padding()
            .frame(maxWidth: .infinity)
            .disabled(!formIsValid)
            .background(Color.icon.opacity(formIsValid ? 1.0 : 0.5))
            .cornerRadius(8)
            .padding(.vertical)
            
            NavigationLink {
                SignUpView()
                    .environmentObject(authViewModel)
            } label: {
                Text("Dont have a existing accont?")
                Text("Sign up").bold()
            }
            .foregroundStyle(.black)
            
            
            Spacer()
        }
        .padding()
        .navigationTitle("Sign In")
        .navigationBarBackButtonHidden(true)
        .onAppear {
            authViewModel.clearLoginInformation()
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
            .environmentObject(AuthenticationViewModel())
    }
}

