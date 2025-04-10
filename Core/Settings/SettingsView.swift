//
//  SettingsView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 02/02/2025.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var settingsViewModel = SettingsViewModel()
    @EnvironmentObject private var vm: AuthenticationViewModel
    @Binding var showSideMenu: Bool
    
    var body: some View {
        VStack {
            MainHeaderView(showSideMenu: $showSideMenu, title: "Settings")
            NavigationStack(path: $settingsViewModel.navigationPath) {
                List {
                    Section("Device") {
                        settingsViewModel.settingsRow(option: .appearance)
                        settingsViewModel.settingsRow(option: .subscriptions)
                        settingsViewModel.settingsRow(option: .notifications)
                        settingsViewModel.settingsRow(option: .contact)
                        settingsViewModel.settingsRow(option: .privacy)
                        settingsViewModel.settingsRow(option: .terms)
                    }
                    
                    Section("Links") {
                        ForEach(LinkOption.allCases) { link in
                            if let url = link.url {
                                Link(destination: url) {
                                    SettingsLabel(title: link.title, imageName: link.imageName)
                                }
                            }
                        }
                    }
                    
                    Section("Account") {
                        SettingsButton(title: "Delete Account", imageName: "minus.circle.fill") {
                            settingsViewModel.showDeleteAlert.toggle()
                        }
                        SettingsButton(title: "Sign out", imageName: "lock.fill") { settingsViewModel.showSignOutAlert.toggle()
                        }
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
        }
        .navigationDestination(for: SettingsOption.self) { option in
            settingsViewModel.settingsDestination(for: option)
        }
        .confirmationDialog("Sign Out", isPresented: $settingsViewModel.showSignOutAlert, titleVisibility: .visible) {
            Button("Yes", role: .destructive) {
                DispatchQueue.main.async {
                    vm.signOut()
                }
            }
        } message: {
            Text("Are you sure that you want to sign out your account?")
        }
        .confirmationDialog("Delete Permanently", isPresented: $settingsViewModel.showDeleteAlert, titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                Task {
                    try await vm.deleteAccount()
                }
            }
        } message: {
            Text("Are you sure that you want to remove your account permanently?")
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSideMenu: .constant(false))
            .environmentObject(AuthenticationViewModel())
    }
}
