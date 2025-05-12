//
//  CircularProfileView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 11/05/2025.
//

import SwiftUI

struct CircularProfileView: View {
    
    var body: some View {
        Image("Barca")
            .resizable()
            .scaledToFill()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            .overlay {
                Circle().stroke(lineWidth: 1)
                    .foregroundStyle(Color(.label))
            }
            .shadow(radius: 4)
    }
}

#Preview {
    CircularProfileView()
}
