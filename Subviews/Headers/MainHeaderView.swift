//
//  ReusableHeaderView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 28/12/2024.
//

import SwiftUI

struct MainHeaderView: View {
    @Binding var showSideMenu: Bool
    @Environment(\.dismiss) var dismiss
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
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(.white)
                            .font(.system(size: 14, weight: .semibold))
                    }
                }
            } else {
                HStack {
                    Text("")
                        .foregroundStyle(.clear)
                    Spacer()
                    Text(title)
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                    Button {
                        showSideMenu.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundStyle(.white)
                            .font(.system(size: 18, weight: .semibold))
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color("icon"))
    }
}

#Preview {
    MainHeaderView(showSideMenu: .constant(false), title: "Settings")
}

