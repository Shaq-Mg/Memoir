//
//  Profile.swift
//  Memoir
//
//  Created by Shaquille McGregor on 02/02/2025.
//

import Foundation

typealias Route = CaseIterable & Identifiable & Hashable

enum Profile: Int, Route {
    case password
    case email
    
    var id: Int { return self.rawValue }
    
    var title: String {
        switch self {
        case .password: return "Password"
        case .email: return "Email"
            
        }
    }
    
    var imageName: String {
        switch self {
        case .password: return "key.fill"
        case .email: return "envelope.fill"
            
        }
    }
}

enum LinkOption: Int, Route {
    case website
    case instagram
    
    var id: Int { return self.rawValue }
    
    var title: String {
        switch self {
        case .website: return "Website"
        case .instagram: return "Instagram"
            
        }
    }
    
    var imageName: String {
        switch self {
        case .website: return "network"
        case .instagram: return "personalhotspot"
            
        }
    }
    
    var url: URL? {
        switch self {
        case .website: return URL(string: "https://swift.org")
        case .instagram: return URL(string: "https://swift.org")
            
        }
    }
}
