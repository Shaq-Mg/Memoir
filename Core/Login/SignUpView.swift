//
//  SignUpView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 27/12/2024.
//

import SwiftUI
import PhotosUI

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            photoPickerSection
            
            InputView(text: $authViewModel.email, placeholder: "Email")
            InputView(text: $authViewModel.password, placeholder: "Password", isSecureField: true)
            InputView(text: $authViewModel.confirmPassword, placeholder: "Confirm password", isSecureField: true)
            
            Text(authViewModel.errorMessage)
                .foregroundStyle(.red)
                .padding()
            
            Button("Create account") {
                Task {
                    try await authViewModel.createUser(withEmail: authViewModel.email, password: authViewModel.password)
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
            
            Button {
                dismiss()
            } label: {
                Text("Already have an existing accont?")
                Text("Sign in").bold()
            }
            .foregroundStyle(.black)
            
            
            Spacer()
        }
        .padding()
        .navigationTitle("Create account")
        .navigationBarBackButtonHidden(true)
        .onAppear { authViewModel.clearLoginInformation() }
        .onChange(of: authViewModel.selectedItem) { _, newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    authViewModel.selectedImageData = data
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SignUpView()
            .environmentObject(AuthenticationViewModel())
    }
}

extension SignUpView {
    private var photoPickerSection: some View {
        PhotosPicker(selection: $authViewModel.selectedItem, matching: .images, photoLibrary: .shared()) {
            if let selectedImage = authViewModel.selectedImageData,
               let uiImage = UIImage(data: selectedImage) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .shadow(radius: 5)
            } else {
                Image(systemName: "person.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(Color(.systemGray))
            }
        }
        .frame(width: 200, height: 200)
    }
}
