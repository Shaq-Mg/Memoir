//
//  SettingsOptions.swift
//  Memoir
//
//  Created by Shaquille McGregor on 22/06/2025.
//

import Foundation

enum SettingsOption: Int, Route {
    case appearance
    case subscriptions
    case notifications
    case contact
    case privacy
    case terms
    
    var id: Int { return self.rawValue }
    
    var title: String {
        switch self {
        case .appearance: return "Appearance"
        case .subscriptions: return "Manage Subscriptions"
        case .notifications: return "Push Notifications"
        case .contact: return "Contact Us"
        case .privacy: return "Privacy Policy"
        case .terms: return "Terms of Service"
       
        }
    }
    
    var imageName: String {
        switch self {
        case .appearance: return "moon.fill"
        case .subscriptions: return "iphone"
        case .notifications: return "bell.badge.fill"
        case .contact: return "message.fill"
        case .privacy: return "shield.righthalf.filled"
        case .terms: return "list.clipboard.fill"
            
        }
    }
    
    var description: String {
        switch self {
        case .appearance: return ""
        case .subscriptions: return ""
        case .notifications: return ""
        case .contact: return ""
        case .privacy: return ""
        case .terms: return ""
            
        }
    }
}
