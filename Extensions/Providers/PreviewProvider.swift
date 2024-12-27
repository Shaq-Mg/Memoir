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
    
    let user = User(id: "", name: "Kobe", email: "Kobe@gmail.com", photoImageUrl: "", isPremium: true)
}
