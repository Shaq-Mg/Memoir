//
//  Appointment.swift
//  Memoir
//
//  Created by Shaquille McGregor on 29/12/2024.
//

import Foundation
import FirebaseFirestore

struct Appointment: Identifiable, Codable {
    @DocumentID var id: String?
    let name: String
    let service: String
    let date: Date
    let time: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case service
        case date
        case time
    }
}
