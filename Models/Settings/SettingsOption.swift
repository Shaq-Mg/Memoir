//
//  Settings.swift
//  Memoir
//
//  Created by Shaquille McGregor on 02/02/2025.
//

import Foundation

enum Settings: Int, Route {
    case deleteAccount
    case signOut
    
    var id: Int { return self.rawValue }
    
    var title: String {
        switch self {
        case .deleteAccount: return "Delete Account"
        case .signOut: return "Sign Out"
            
        }
    }
    
    var imageName: String {
        switch self {
        case .deleteAccount: return "minus.circle"
        case .signOut: return "lock"
            
        }
    }
    
}

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
        case .privacy: return "Private Policy"
        case .terms: return "Terms of Service"
       
        }
    }
    
    var imageName: String {
        switch self {
        case .appearance: return "moon"
        case .subscriptions: return "iphone"
        case .notifications: return "bell.badge"
        case .contact: return "message"
        case .privacy: return "shield.righthalf.filled"
        case .terms: return "list.clipboard"
            
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
