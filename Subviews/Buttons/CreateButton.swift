//
//  CreateButton.swift
//  Memoir
//
//  Created by Shaquille McGregor on 28/12/2024.
//

import SwiftUI

struct CreateButton: View {
    var body: some View {
        VStack {
            Image(systemName: "plus")
                .font(.system(size: 10, weight: .bold))
                .padding(4)
                .overlay(Circle().stroke(lineWidth: 3))
                .foregroundStyle(Color(.darkGray))
        }
    }
}

#Preview {
    CreateButton()
}
