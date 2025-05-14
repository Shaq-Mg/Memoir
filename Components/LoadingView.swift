//
//  LoadingView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 13/05/2025.
//

import SwiftUI

struct LoadingView: View {
    let title: String
    
    var body: some View {
        VStack(spacing: 8) {
            ProgressView()
            Text(title)
        }
        .font(.system(size: 20))
    }
}

#Preview {
    LoadingView(title: "Fetching clients")
}
