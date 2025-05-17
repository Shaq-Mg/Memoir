//
//  Service.swift
//  Memoir
//
//  Created by Shaquille McGregor on 15/05/2025.
//

import FirebaseFirestore

struct Service: FirebaseModel {
    @DocumentID var docId: String?
    var title: String
    let price: Double
    
    var id: String {
        return docId ?? UUID().uuidString
    }
    
    var description: String {
        return title
    }
    
    enum CodingKeys: String, CodingKey {
        case docId = "doc_id"
        case title
        case price
    }
}
