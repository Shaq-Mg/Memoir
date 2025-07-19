//
//  SettingsView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 22/06/2025.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var vm = SettingsViewModel()
    @Binding var showSideMenu: Bool
    
    var body: some View {
        VStack {
            MenuHeaderView(showSideMenu: $showSideMenu, title: "Settings")
            NavigationStack(path: $vm.navigationPath) {
                List {
                    Section("Device") {
                        vm.settingsRow(option: .appearance)
                        vm.settingsRow(option: .subscriptions)
                        vm.settingsRow(option: .notifications)
                        vm.settingsRow(option: .contact)
                        vm.settingsRow(option: .privacy)
                        vm.settingsRow(option: .terms)
                    }
                    
                    Section("Links") {
                        ForEach(LinkOption.allCases) { link in
                            if let url = link.url {
                                Link(destination: url) {
                                    SettingsLabelView(title: link.title, imageName: link.imageName)
                                }
                            }
                        }
                    }
                    
                    Section("Account") {
                        SettingsButtonView(title: "Delete Account", imageName: "minus.circle.fill") {
                            vm.showDeleteConfirmation.toggle()
                        }
                        SettingsButtonView(title: "Sign out", imageName: "lock.fill") { vm.showSignOutConfirmation.toggle()
                        }
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
        }
        .navigationDestination(for: SettingsOption.self) { option in
            vm.settingsDestination(for: option)
        }
        .alert("Sign Out", isPresented: $vm.showSignOutConfirmation) {
            Button("Yes", role: .destructive) {
                DispatchQueue.main.async {
                    vm.signOut()
                }
            }
        } message: {
            Text("Are you sure that you want to sign out your account?")
        }
        .confirmationDialog("Delete Account", isPresented: $vm.showDeleteConfirmation, titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                Task { try await vm.deleteAccount() }
            }
            Button("Dismiss", role: .cancel) { }
        } message: {
            Text("Are you sure that you want to permanently remove your account?")
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSideMenu: .constant(false))
    }
}
