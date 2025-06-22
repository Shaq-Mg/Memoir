//
//  Appointment.swift
//  Memoir
//
//  Created by Shaquille McGregor on 17/05/2025.
//

import FirebaseFirestore

struct Appointment: FirebaseModel {
    @DocumentID var id: String?
    var name: String
    var description: String
    let amount: Double
    var date: Date // Just date, no time component
    var time: Date  // Timestamp with full date+time
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case amount
        case date
        case time
    }
}

// Data model for chart selection state
enum ChartState: String, Identifiable, CaseIterable {
    case next7Days = "This week"
    case last7Days = "Last week"
    
    var id: String {
        return rawValue
    }
}
