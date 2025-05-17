//
//  PreviewProvider.swift
//  Memoir
//
//  Created by Shaquille McGregor on 13/05/2025.
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
    
    let calender = Calender(day: 2, date: Date())
    let client = Client(name: "Kobe", phoneNumber: "07800000000", note: nil, isFavourite: true)
    let service1 = Service(title: "Haircut", price: 20.00)
    let service2 = Service(title: "Haircut & beard", price: 25.00)
    let user = User(name: "Kobe", email: "Kobe@gmail.com", profileImageUrl: "")
}
