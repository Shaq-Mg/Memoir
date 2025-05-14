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
    
    let client = Client(name: "Kobe", phoneNumber: "07800000000", note: nil, isFavourite: true)
    let user = User(name: "Kobe", email: "Kobe@gmail.com", profileImageUrl: "")
}
