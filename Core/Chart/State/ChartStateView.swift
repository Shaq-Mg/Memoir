//
//  ChartStateView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 26/01/2025.
//

import SwiftUI
import Charts

struct ChartStateView: View {
    @EnvironmentObject private var vm: ChartViewModel
    @AppStorage("chartState") private var chartState: ChartState = .next7Days
    @State private var selectedOption: ChartState? = nil
    
    var body: some View {
        Group {
            if chartState == .next7Days {
                Next7Days(chartState: $chartState, selectedOption: $selectedOption)
            }
            
            if chartState == .last7Days {
                Last7Days(chartState: $chartState, selectedOption: $selectedOption)
            }
        }
    }
}

#Preview {
    ChartStateView()
        .environmentObject(ChartViewModel())
}
