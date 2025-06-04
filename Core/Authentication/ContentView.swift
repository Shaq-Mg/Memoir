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
    private let chartManager = ChartManager()
    
    var body: some View {
        if viewModel.userSession != nil {
            ChartStateView(chartManager: chartManager)
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
