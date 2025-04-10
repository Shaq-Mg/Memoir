//
//  PreviewProvider.swift
//  Memoir
//
//  Created by Shaquille McGregor on 27/12/2024.
//

import SwiftUI

extension Preview {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() { }
    
    let appt1 = Appointment(name: "Kobe", description: "Haircut", earnings: 15.00, date: Date(), time: Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? .now)
    let appt2 = Appointment(name: "Lamelo", description: "Haircut & Beard", earnings: 20.00, date: Date(), time: Calendar.current.date(byAdding: .hour, value: 2, to: Date()) ?? .now)
    let client = Client(name: "Kobe", phoneNumber: "07800000000", nickname: "Mamba", isFavourite: true)
    let user = User(name: "Kobe", email: "Kobe@gmail.com", imageUrl: "", isPremium: true)
    let service1 = Service(title: "Haircut", price: 15.00)
    let service2 = Service(title: "Shave", price: 10.00)
}
