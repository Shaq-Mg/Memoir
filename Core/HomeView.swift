//
//  HomeView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 27/12/2024.
//

import SwiftUI

struct HomeView: View {
    @State private var isMenuShowing = false
    var body: some View {
        ClientView(showSideMenu: $isMenuShowing)
    }
}

#Preview {
    HomeView()
}
