//
//  Next7Days.swift
//  Memoir
//
//  Created by Shaquille McGregor on 02/06/2025.
//

import SwiftUI
import Charts

struct Next7Days: View {
    @EnvironmentObject private var vm: ChartViewModel
    @State private var startDate = Date()
    @Binding var chartState: ChartState
    @Binding var selectedOption: ChartState?
    
    var body: some View {
        VStack(spacing: 14) {
            ChartHeaderView(chartState: $chartState, earnings: vm.calculateTotalEarnings(from: vm.appointments))
            // Chart View
            Chart {
                if let selectedDate = vm.selectedDate {
                    RuleMark(x: .value("Selected Day", selectedDate.date, unit: .day))
                        .foregroundStyle(Color(.darkGray).opacity(0.3))
                        .annotation(position: .top, overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
                            ChartAnnotation(date: selectedDate.date, earnings: vm.calculateTotalEarnings(from: vm.appointments))
                        }
                }
                
                ForEach(vm.fetchUpcomingAppts(from: startDate), id: \.date) { appt in
                    BarMark(
                        x: .value("Date", appt.date, unit: .day),
                        y: .value("Appointment", appt.count)
                    )
                    .foregroundStyle(.accent.gradient)
                    .opacity(vm.rawSelectedDate == nil || appt.date == vm.selectedDate?.date ? 1.0 : 0.3)
                }
            }
            .chartXSelection(value: $vm.rawSelectedDate.animation(.easeInOut))
            .chartYAxis(.hidden)
            .chartXAxis {
                AxisMarks { mark in
                    AxisValueLabel(centered: false)
                }
            }
            .frame(height: 180)
            ChartPickerView(chartState: $chartState)
        }
        .onAppear { vm.generateNext7daysEarnings() }
    }
}

#Preview {
    Next7Days(chartState: .constant(.next7Days), selectedOption: .constant(.next7Days))
        .environmentObject(ChartViewModel())
}

