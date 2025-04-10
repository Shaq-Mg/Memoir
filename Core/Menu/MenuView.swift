//
//  MenuView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 01/02/2025.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject private var viewModel: AuthenticationViewModel
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
                        menuHeader
                        VStack {
                            
                        }
                        ForEach(Page.allCases) { page in
                            Button {
                                selectedOption = page
                                selectedTab = page.rawValue
                                isMenuShowing = false
                            } label: {
                                MenuLabel(selectedOption: $selectedOption, page: page)
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
        .task { await viewModel.fetchUser() }
        .animation(.easeInOut, value: isMenuShowing)
    }
}

#Preview {
    MenuView(isMenuShowing: .constant(true), selectedTab: .constant(0))
        .environmentObject(AuthenticationViewModel())
}

extension MenuView {
    private var menuHeader: some View {
        VStack {
            HStack(spacing: 8) {
                Image(systemName: "person.fill")
                    .font(.system(size: 16))
                    .foregroundStyle(.dark)
                    .padding(8)
                    .background(Circle().foregroundStyle(.icon.opacity(0.5)))
                    .shadow(radius: 2)
                
                Text(viewModel.dataService.currentUser?.email ?? "profile")
                    .font(.headline).italic()
                    .foregroundStyle(.secondary)
                Spacer()
            }
            Divider()
        }
    }
}
