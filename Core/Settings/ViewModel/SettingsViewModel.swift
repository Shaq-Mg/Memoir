//
//  SettingsViewModel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 02/02/2025.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var navigationPath = [SettingsOption]()
    @Published var showSignOutAlert = false
    @Published var showDeleteAlert = false
    
    // Creates a row for each setting option
    func settingsRow(option: SettingsOption) -> some View {
        Button {
            self.navigationPath.append(option)
        } label: {
            SettingsLabel(title: option.title, imageName: option.imageName)
        }
    }
    
    @ViewBuilder
    func settingsDestination(for option: SettingsOption) -> some View {
        switch option {
        case .appearance: AppearanceSheet()
        case  .subscriptions: SubscriptionSheet()
        case .notifications: NotificationSheet()
        case .contact: InformationSheet(option: .contact)
        case .privacy: InformationSheet(option: .privacy)
        case .terms: InformationSheet(option: .terms)
            
        }
    }
}
