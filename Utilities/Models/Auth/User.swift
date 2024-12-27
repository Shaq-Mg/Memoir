//
//  User.swift
//  Memoir
//
//  Created by Shaquille McGregor on 27/12/2024.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
    let imageUrl: String
    var isPremium: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case email = "email"
        case imageUrl = "image_url"
        case isPremium = "is_premium"
    }
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: name) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}
