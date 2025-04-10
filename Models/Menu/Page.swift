//
//  Page.swift
//  Memoir
//
//  Created by Shaquille McGregor on 01/02/2025.
//

import Foundation

enum Page: Int, Hashable , CaseIterable {
    case home, client, service, schedule, settings
    
    var title: String {
        switch self {
        case .client: return "Clients"
        case .service: return "Services"
        case .schedule: return "Schedule"
        case .home: return "Home"
        case .settings: return "Settings"
        }
    }
    
    var iconName: String {
        switch self {
        case .client: return "person.2.fill"
        case .service: return "briefcase.fill"
        case .schedule: return "calendar"
        case .home: return "house.fill"
        case .settings: return "gear"
        }
    }
}

extension Page: Identifiable {
    var id: Int { return self.rawValue }
}
