//
//  SideMenuView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 23/06/2025.
//

import SwiftUI

struct SideMenuView: View {
    @StateObject private var vm = MenuViewModel()
    @State private var selectedOption: Page? = nil
    @Binding var isMenuShowing: Bool
    @Binding var selectedTab: Int
    var body: some View {
        ZStack {
            if isMenuShowing {
                Rectangle()
                    .foregroundStyle(.ultraThinMaterial)
                    .ignoresSafeArea()
                    .onTapGesture { isMenuShowing.toggle() }
                HStack {
                    VStack(alignment: .leading, spacing: 26) {
                        SideMenuHeader()
                        
                        ForEach(Page.allCases) { page in
                            Button {
                                selectedOption = page
                                selectedTab = page.rawValue
                                isMenuShowing = false
                            } label: {
                                MenuLabelView(selectedOption: $selectedOption, page: page)
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(width: 270, alignment: .leading)
                    .background(.white)
                    Spacer()
                }
                .transition(.move(edge: .leading))
            }
        }
        .task { await vm.fetchUser() }
        .animation(.easeInOut, value: isMenuShowing)
    }
}

#Preview {
    SideMenuView(isMenuShowing: .constant(true), selectedTab: .constant(0))
        .environmentObject(MenuViewModel())
}

