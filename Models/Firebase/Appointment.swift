//
//  Appointment.swift
//  Memoir
//
//  Created by Shaquille McGregor on 17/05/2025.
//

import FirebaseFirestore

struct Appointment: FirebaseModel {
    @DocumentID var id: String?
    let name: String
    let description: String
    let earnings: Double
    let date: Date
    let time: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case earnings
        case date
        case time
    }
}
