//
//  EditProfileView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 15/07/2025.
//

import SwiftUI

struct EditProfileView: View {
    @StateObject private var vm = EditProfileViewModel()
    @Environment(\.dismiss) private var dismiss
    let user: User?
    
    var body: some View {
        ZStack {
            Color(Color(.systemGroupedBackground)).ignoresSafeArea()
            VStack {
                photoPickerButton
                    .padding(.bottom, 44)
                VStack(alignment: .leading, spacing: 12) {
                    InputDetailView(title: "Name", description: user?.name ?? "-")
                    
                    InputDetailView(title: "Email", description: user?.email ?? "-")
                }
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundStyle(Color(.systemGray3))
                }
                .padding()
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                CancelButtonView(fontSize: .footnote, fontColor: Color(.label))
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    Task { try await vm.updateUserData() }
                    dismiss()
                }
            }
        }
        .font(.subheadline)
        .fontWeight(.semibold)
        .foregroundStyle(Color(.label))
    }
}

#Preview {
    NavigationStack {
        EditProfileView(user: Preview.dev.user)
    }
}

extension EditProfileView {
    private var photoPickerButton: some View {
        Button {
            
        } label: {
            CircularProfileView(user: user, size: .xLarge)
        }
    }
}
