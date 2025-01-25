//
//  Service.swift
//  Memoir
//
//  Created by Shaquille McGregor on 29/12/2024.
//

import Foundation
import FirebaseFirestore

typealias Selection = CustomStringConvertible & Identifiable & Codable & Equatable

struct Service: Selection {
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
