//
//  AppHeaderView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 13/05/2025.
//

import SwiftUI

struct AppHeaderView: View {
    @Binding var showSideMenu: Bool
    @Namespace private var namespace
    var onDismiss = false
    let title: String
    
    var body: some View {
        VStack {
            if onDismiss {
                HStack {
                    Text("------")
                        .foregroundStyle(.clear)
                    Spacer()
                    Text(title)
                        .foregroundStyle(.white)
                        .font(.system(size: 16, weight: .semibold))
                    Spacer()
                    CancelButtonView(fontSize: .headline, fontColor: .white)
                }
            } else {
                HStack {
                    Image(systemName: "line.3.horizontal")
                        .foregroundStyle(.clear)
                    Spacer()
                    Text(title)
                        .foregroundStyle(.white)
                    Spacer()
                    Button {
                        showSideMenu.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundStyle(.white)
                    }
                }
                .font(.system(size: 25, weight: .semibold))
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .animation(.easeInOut, value: showSideMenu)
        .matchedGeometryEffect(id: "menu", in: namespace)
        .background(Color("AccentColor"))
    }
}

#Preview {
    AppHeaderView(showSideMenu: .constant(false), title: "Settings")
}
