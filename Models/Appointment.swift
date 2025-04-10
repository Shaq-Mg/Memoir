//
//  Appointment.swift
//  Memoir
//
//  Created by Shaquille McGregor on 22/01/2025.
//

import Foundation
import FirebaseFirestore

struct Appointment: Identifiable, Codable, Hashable {
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

enum ChartState: String, Identifiable, CaseIterable {
    case next7Days = "This week"
    case last7Days = "Last week"
    
    var id: String {
        return rawValue
    }
}
