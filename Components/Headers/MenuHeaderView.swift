//
//  MenuHeaderView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 13/05/2025.
//

import SwiftUI

struct MenuHeaderView: View {
    @Binding var showSideMenu: Bool
    @Namespace private var animation
    let title: String
    
    var body: some View {
        HStack {
            Button {
                showSideMenu.toggle()
            } label: {
                Image(systemName: "line.3.horizontal")
                    .foregroundStyle(.white)
                    .font(.system(size: 25, weight: .semibold))
            }
            Spacer()
            Text(title)
                .foregroundStyle(.white)
            Spacer()
            Image(systemName: "line.3.horizontal")
                .foregroundStyle(.clear)
        }
        .font(.system(size: 22, weight: .semibold))
        .padding()
        .frame(maxWidth: .infinity)
        .animation(.easeInOut, value: showSideMenu)
        .matchedGeometryEffect(id: "menu", in: animation)
        .background(Color("AccentColor"))
    }
}

#Preview {
    MenuHeaderView(showSideMenu: .constant(false), title: "Settings")
}
