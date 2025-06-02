//
//  AppointmentManager.swift
//  Memoir
//
//  Created by Shaquille McGregor on 17/05/2025.
//

import FirebaseAuth
import FirebaseFirestore

class AppointmentManager {
    
    static let shared = AppointmentManager()
    
    private init() { }
    
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
}
