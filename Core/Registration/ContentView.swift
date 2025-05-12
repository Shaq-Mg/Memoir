//
//  ContentView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 09/05/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    var body: some View {
        if viewModel.userSession != nil {
            EditProfileView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
