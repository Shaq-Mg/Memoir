//
//  ChartStateView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 03/06/2025.
//

import SwiftUI

struct ChartStateView: View {
    @StateObject private var vm: ChartViewModel
    @AppStorage("chartState") private var chartState: ChartState = .next7Days
    @State private var selectedOption: ChartState? = nil
    
    init(chartManager: ChartManager) {
        _vm = StateObject(wrappedValue: ChartViewModel(chartManager: chartManager))
    }
    
    var body: some View {
        Group {
            if chartState == .next7Days {
                Next7Days(chartState: $chartState, selectedOption: $selectedOption)
                    .environmentObject(vm)
            }
            
            if chartState == .last7Days {
                Last7Days(chartState: $chartState, selectedOption: $selectedOption)
                    .environmentObject(vm)
            }
        }
        .onAppear {
            if chartState == .next7Days {
                vm.fetchNext7daysData()
            }
            if chartState == .last7Days {
                vm.fetchLast7daysData()
            }
        }
    }
}

#Preview {
    let chartManager = ChartManager()
    ChartStateView(chartManager: chartManager)
        .environmentObject(ChartViewModel(chartManager: chartManager))
}
