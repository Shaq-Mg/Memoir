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
    
    let client = Client(name: "Kobe", phoneNumber: "07800000000", nickname: "Mamba", isFavourite: true)
    let user = User(id: "", name: "Kobe", email: "Kobe@gmail.com", imageUrl: "", isPremium: true)
    let service = Service(id: nil, title: "Haircut", price: "£25", duration: "40 mins")
}
