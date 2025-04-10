//
//  HomeView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 27/12/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var apptVM: ApptViewModel
    @EnvironmentObject private var authVM: AuthenticationViewModel
    @EnvironmentObject private var calenderVM: CalenderViewModel
    @StateObject private var chartVM = ChartViewModel()
    @EnvironmentObject private var clientVM: ClientViewModel
    @EnvironmentObject private var serviceVM: ServiceViewModel
    @State private var selectedTab = 0
    @State private var isMenuShowing = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                TabView(selection: $selectedTab) {
                    ChartView(isMenuShowing: $isMenuShowing)
                        .environmentObject(authVM)
                        .environmentObject(chartVM)
                        .tag(0)
                    
                    ClientView(showSideMenu: $isMenuShowing)
                        .environmentObject(clientVM)
                        .tag(1)
                    
                    ServiceView(showSideMenu: $isMenuShowing)
                        .environmentObject(serviceVM)
                        .tag(2)
                    
                    ScheduleView(showSideMenu: $isMenuShowing)
                        .environmentObject(calenderVM)
                        .tag(3)
                    
                    SettingsView(showSideMenu: $isMenuShowing)
                        .environmentObject(authVM)
                        .tag(4)
                }
                .tint(Color.accentColor)
            }
            MenuView(isMenuShowing: $isMenuShowing, selectedTab: $selectedTab)
                .environmentObject(authVM)
        }
        .task { await authVM.fetchUser() }
        .navigationBarBackButtonHidden()
    }
}
