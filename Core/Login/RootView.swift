//
//  RootView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 02/03/2025.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    var body: some View {
        NavigationStack {
            if authViewModel.dataService.userSession != nil {
                HomeView()
                    .environmentObject(authViewModel)
            } else {
                LoginView()
                    .environmentObject(authViewModel)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationStack {
        RootView()
            .environmentObject(AuthenticationViewModel())
    }
}
