//
//  SideMenuHeaderView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 23/06/2025.
//

import SwiftUI

struct SideMenuHeaderView: View {
    @EnvironmentObject private var vm: MenuViewModel
    var body: some View {
        NavigationLink {
            EditProfileView(user: vm.currentUser)
        } label: {
            VStack {
                HStack(alignment: .center, spacing: 8) {
                    CircularProfileImageView(user: vm.currentUser, size: .medium)
                    
                    Text(vm.currentUser?.email.lowercased() ?? "n/a")
                        .font(.headline)
                        .foregroundStyle(Color(.label))
                    Spacer()
                }
                Divider()
            }
        }
    }
}

#Preview {
    SideMenuHeaderView()
        .environmentObject(MenuViewModel())
}
