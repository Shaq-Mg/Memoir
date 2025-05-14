//
//  EditProfileView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 11/05/2025.
//

import SwiftUI

struct EditProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            VStack {
                HStack(alignment: .top) {
                    InputView(text: $viewModel.name, title: "Name", placeholder: "Kobe")
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        CircularProfileView()
                    }
                }
                Divider()
                    .padding(.vertical, 10)
                InputView(text: $viewModel.email, title: "Email", placeholder: "kobe@gmail.com")
            }
            .padding()
            .background(Color("AppBackground"))
            .background(RoundedRectangle(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.systemGray3), lineWidth: 1)
            }
            .padding()
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                CancelButtonView(fontSize: .footnote, fontColor: Color(.label))
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    
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
        EditProfileView()
    }
}
