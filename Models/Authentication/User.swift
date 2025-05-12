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
    let profileImageUrl: String
    
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
