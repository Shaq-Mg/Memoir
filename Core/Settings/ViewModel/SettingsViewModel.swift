//
//  SettingsViewModel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 22/06/2025.
//

import FirebaseAuth
import Combine
import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var navigationPath = [SettingsOption]()
    @Published var showSignOutConfirmation = false
    @Published var showDeleteConfirmation = false
    @Published var userSession: FirebaseAuth.User?
    
    private let authService = AuthService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setUpSubscribers()
    }
    
    private func setUpSubscribers() {
        authService.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }.store(in: &cancellables)
    }
    
    func signOut() {
        authService.signOut()
    }
    
    func deleteAccount() async throws {
        try await authService.deleteAccount()
    }
    
    // Creates a row for each setting option
    func settingsRow(option: SettingsOption) -> some View {
        Button {
            self.navigationPath.append(option)
        } label: {
            SettingsLabelView(title: option.title, imageName: option.imageName)
        }
    }
    
    @ViewBuilder
    func settingsDestination(for option: SettingsOption) -> some View {
        switch option {
        case .appearance: AppearanceSheet()
        case .subscriptions: SubscriptionSheet()
        case .notifications: NotificationSheet()
        case .contact: InformationSheet(option: .contact)
        case .privacy: InformationSheet(option: .privacy)
        case .terms: InformationSheet(option: .terms)
            
        }
    }
}
