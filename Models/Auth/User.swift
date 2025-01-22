//
//  User.swift
//  Memoir
//
//  Created by Shaquille McGregor on 27/12/2024.
//

import Foundation
import FirebaseFirestore

struct User: Identifiable, Codable {
    @DocumentID var uid: String?
    let name: String
    let email: String
    let imageUrl: String
    var isPremium: Bool?
    
    var id: String {
        return uid ?? UUID().uuidString
    }
    
    enum CodingKeys: String, CodingKey {
        case uid = "uid"
        case name = "name"
        case email = "email"
        case imageUrl = "image_url"
        case isPremium = "is_premium"
    }
}
