//
//  InformationSheet.swift
//  Memoir
//
//  Created by Shaquille McGregor on 22/06/2025.
//

import SwiftUI

struct InformationSheet: View {
    let option: SettingsOption
    
    var body: some View {
        Text(option.title)
    }
}

#Preview {
    InformationSheet(option: .contact)
}
