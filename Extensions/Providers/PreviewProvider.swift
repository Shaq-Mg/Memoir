//
//  PreviewProvider.swift
//  Memoir
//
//  Created by Shaquille McGregor on 27/12/2024.
//

import Foundation
import SwiftUI

extension Preview {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() { }
    
    let appointment = Appointment(name: "Kobe", description: "Haircut", earnings: 15.00, date: Date(), time: .now)
    let client = Client(name: "Kobe", phoneNumber: "07800000000", nickname: "Mamba", isFavourite: true)
    let user = User(uid: "", name: "Kobe", email: "Kobe@gmail.com", imageUrl: "", isPremium: true)
    let service1 = Service(title: "Haircut", price: 15.00)
    let service2 = Service(title: "Shave", price: 10.00)
}
