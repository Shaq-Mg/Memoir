//
//  User.swift
//  Memoir
//
//  Created by Shaquille McGregor on 11/05/2025.
//

import FirebaseFirestore

struct User: Identifiable, Codable {
    @DocumentID var uid: String?
    let name: String
    let email: String
    var profileImageUrl: String
    
    var id: String {
        return uid ?? UUID().uuidString
    }
    
    enum CodingKeys: String, CodingKey {
        case uid = "uid"
        case name = "name"
        case email = "email"
        case profileImageUrl = "profile_image_url"
    }
}

enum ProfileImageSize {
    case xSmall
    case small
    case medium
    case large
    case xLarge
    
    var dimension: CGFloat {
        switch self {
        case .xSmall: return 28
        case .small: return 32
        case .medium: return 40
        case .large: return 48
        case .xLarge: return 64
            
        }
    }
}
