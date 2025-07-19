//
//  SideMenuHeader.swift
//  Memoir
//
//  Created by Shaquille McGregor on 23/06/2025.
//

import SwiftUI

struct SideMenuHeader: View {
    @EnvironmentObject private var vm: MenuViewModel
    var body: some View {
        NavigationLink {
            
        } label: {
            VStack {
                HStack(spacing: 6) {
                    Image(systemName: "person.circle")
                        .font(.system(size: 32))
                        .foregroundStyle(Color(.systemGray3))
                    
                    Text(vm.currentUser?.email ?? "user")
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
    SideMenuHeader()
        .environmentObject(MenuViewModel())
}
