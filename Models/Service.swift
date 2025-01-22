//
//  Service.swift
//  Memoir
//
//  Created by Shaquille McGregor on 29/12/2024.
//

import Foundation
import FirebaseFirestore

struct Service: Identifiable, Codable {
    @DocumentID var id: String?
    let title: String
    let price: String
    let duration: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case duration
    }
}
