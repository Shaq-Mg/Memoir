//
//  Next7Days.swift
//  Memoir
//
//  Created by Shaquille McGregor on 26/01/2025.
//

import SwiftUI

struct Next7Days: View {
    @EnvironmentObject private var viewModel: ChartViewModel
    @State private var startDate = Date()
    @Binding var chartState: ChartState
    @Binding var selectedOption: ChartState?
    
    var body: some View {
        VStack(spacing: 14) {
            ChartHeaderView(chartState: $chartState, earnings: viewModel.calculateTotalEarnings(from: viewModel.apptService.appointments))
            // Chart View
            Chart {
                if let selectedDate = viewModel.selectedDate {
                    RuleMark(x: .value("Selected Day", selectedDate.date, unit: .day))
                        .foregroundStyle(Color(.darkGray).opacity(0.3))
                        .annotation(position: .top, overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
                            ChartAnnotation(date: selectedDate.date, earnings: viewModel.totalEarningsForDate(for: selectedDate.date))
                        }
                }
                
                ForEach(viewModel.fetchNext7Days(from: startDate), id: \.date) { appt in
                    BarMark(
                        x: .value("Date", appt.date, unit: .day),
                        y: .value("Appointment", appt.count)
                    )
                    .foregroundStyle(.indigo.gradient)
                    .opacity(viewModel.rawSelectedDate == nil || appt.date == viewModel.selectedDate?.date ? 1.0 : 0.3)
                }
            }
            .chartXSelection(value: $viewModel.rawSelectedDate.animation(.easeInOut))
            .chartYAxis(.hidden)
            .chartXAxis {
                AxisMarks { mark in
                    AxisValueLabel(centered: false)
                }
            }
            .frame(height: 180)
            ChartPicker(chartState: $chartState)
        }
    }
}

#Preview {
    Next7Days()
}
