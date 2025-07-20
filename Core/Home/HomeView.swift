//
//  HomeView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 20/07/2025.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab = 0
    @State private var isMenuShowing = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                TabView(selection: $selectedTab) {
                    ChartView(isMenuShowing: $isMenuShowing)
                        .tag(0)
                    
                    ClientView(showSideMenu: $isMenuShowing)
                        .tag(1)
                    
                    ServiceView(showSideMenu: $isMenuShowing)
                        .tag(2)
                    
                    Text("Schedule View")
                        .tag(3)
                    
                    SettingsView(showSideMenu: $isMenuShowing, user: <#User?#>)
                        .tag(4)
                }
                .tint(Color.accentColor)
            }
            SideMenuView(isMenuShowing: $isMenuShowing, selectedTab: $selectedTab)
        }
        .navigationBarBackButtonHidden()
    }
}


#Preview {
    HomeView()
}
