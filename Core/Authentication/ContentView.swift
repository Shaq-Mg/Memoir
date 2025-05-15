//
//  ContentView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 09/05/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var isMenuShowing = false
    var body: some View {
        if viewModel.userSession != nil {
            ClientView(showSideMenu: $isMenuShowing)
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
