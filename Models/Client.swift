//
//  Client.swift
//  Memoir
//
//  Created by Shaquille McGregor on 28/12/2024.
//

import Foundation
import FirebaseFirestore

struct Client: Selection {
    @DocumentID var docId: String?
    let name: String
    let phoneNumber: String
    let nickname: String?
    let isFavourite: Bool
    
    var id: String {
        return docId ?? UUID().uuidString
    }
    
    var description: String {
        return name
    }
    
    enum CodingKeys: String, CodingKey {
        case docId = "doc_id"
        case name = "name"
        case phoneNumber = "phone_number"
        case nickname = "nickname"
        case isFavourite = "is_favourite"
    }
}
