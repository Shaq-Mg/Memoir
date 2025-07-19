//
//  CircularProfileView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 11/05/2025.
//

import SwiftUI
import Kingfisher

struct CircularProfileView: View {
    let user: User?
    let size: ProfileImageSize
    
    var body: some View {
        if let imageUrl = user?.profileImageUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .frame(width: size.dimension, height: size.dimension)
                .foregroundStyle(Color(.darkGray))
        }
    }
}

#Preview {
    CircularProfileView(user: Preview.dev.user, size: .medium)
}
