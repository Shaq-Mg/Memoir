//
//  Service.swift
//  Memoir
//
//  Created by Shaquille McGregor on 29/12/2024.
//

import Foundation
import FirebaseFirestore

struct Service: CustomStringConvertible, Identifiable, Codable, Equatable {
    var id = UUID().uuidString
    var title: String
    let price: Double
    
    var description: String {
        return title
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
    }
}
