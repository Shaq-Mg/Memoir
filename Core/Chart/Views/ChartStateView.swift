//
//  ChartStateView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 03/06/2025.
//

import SwiftUI

struct ChartStateView: View {
    @StateObject var viewModel: ChartViewModel
    @AppStorage("chartState") private var chartState: ChartState = .next7Days
    @State private var selectedOption: ChartState? = nil
    
    var body: some View {
        Group {
            if chartState == .next7Days {
                Next7Days(chartState: $chartState, selectedOption: $selectedOption)
                    .environmentObject(viewModel)
            }
            
            if chartState == .last7Days {
                Last7Days(chartState: $chartState, selectedOption: $selectedOption)
                    .environmentObject(viewModel)
            }
        }
        .onAppear {
            if chartState == .next7Days {
                viewModel.fetchNext7daysData()
            }
            if chartState == .last7Days {
                viewModel.fetchLast7daysData()
            }
        }
    }
}

#Preview {
    ChartStateView(viewModel: ChartViewModel())
}
