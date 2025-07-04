//
//  Client.swift
//  Memoir
//
//  Created by Shaquille McGregor on 12/05/2025.
//

import FirebaseFirestore

struct Client: FirebaseModel {
    @DocumentID var docId: String?
    var name: String
    var phoneNumber: String
    var note: String?
    var isFavourite: Bool
    
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
        case note = "note"
        case isFavourite = "is_favourite"
    }
}
