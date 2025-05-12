//
//  Client.swift
//  Memoir
//
//  Created by Shaquille McGregor on 12/05/2025.
//

import FirebaseFirestore

struct Client: FirebaseModel {
    @DocumentID var docId: String?
    let name: String
    let phoneNumber: String
    let note: String?
    var isFavourite: Bool
    
    var id: String {
        return docId ?? UUID().uuidString
    }
    
    var description: String {
        return name
    }
    
    mutating func favouriteStatus(newValue: Bool) {
        self.isFavourite = newValue
    }
    
    enum CodingKeys: String, CodingKey {
        case docId = "doc_id"
        case name = "name"
        case phoneNumber = "phone_number"
        case note = "note"
        case isFavourite = "is_favourite"
    }
}
