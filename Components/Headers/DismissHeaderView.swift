//
//  DismissHeaderView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 15/05/2025.
//

import SwiftUI

struct DismissHeaderView: View {
    let title: String
    
    var body: some View {
        HStack {
            CancelButtonView(fontSize: .body, fontColor: .white)
                .fontWeight(.semibold)
            Spacer()
            Text(title)
                .foregroundStyle(.white)
            Spacer()
            Text("------")
                .foregroundStyle(.clear)
        }
        .font(.system(size: 22, weight: .semibold))
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color("AccentColor"))
    }
}

#Preview {
    DismissHeaderView(title: "Home")
}
