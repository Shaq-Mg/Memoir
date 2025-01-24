//
//  Service.swift
//  Memoir
//
//  Created by Shaquille McGregor on 29/12/2024.
//

import Foundation
import FirebaseFirestore

struct Service: CustomStringConvertible, Identifiable, Codable, Equatable {
    @DocumentID var id: String?
    var title: String
    let price: Double
    let duration: Double
    
    var description: String {
        return title
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case duration
    }
}
