//
//  Settings.swift
//  Memoir
//
//  Created by Shaquille McGregor on 02/02/2025.
//

import Foundation

enum SettingsOptions: Int, Route {
    case subscriptions
    case deleteAccount
    case signOut
    
    var id: Int { return self.rawValue }
    
    var title: String {
        switch self {
        case .subscriptions: return "Manage Subscriptions"
        case .deleteAccount: return "Delete Account"
        case .signOut: return "Sign Out"
            
        }
    }
    
    var imageName: String {
        switch self {
        case .subscriptions: return "iphone"
        case .deleteAccount: return "minus.circle"
        case .signOut: return "lock"
            
        }
    }
    
}

enum Device: Int, Route {
    case appearance
    case notifications
    case contact
    case privacy
    case terms
    
    var id: Int { return self.rawValue }
    
    var title: String {
        switch self {
        case .appearance: return "Appearance"
        case .notifications: return "Push Notifications"
        case .contact: return "Contact Us"
        case .privacy: return "Private Policy"
        case .terms: return "Terms of Service"
       
        }
    }
    
    var imageName: String {
        switch self {
        case .appearance: return "moon"
        case .notifications: return "bell.badge"
        case .contact: return "message"
        case .privacy: return "shield.righthalf.filled"
        case .terms: return "list.clipboard"
            
        }
    }
}
