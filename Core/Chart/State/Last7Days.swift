//
//  Last7Days.swift
//  Memoir
//
//  Created by Shaquille McGregor on 26/01/2025.
//

import SwiftUI
import Charts

struct Last7Days: View {
    @EnvironmentObject private var vm: ChartViewModel
    @Binding var chartState: ChartState
    @Binding var selectedOption: ChartState?
    
    var body: some View {
        VStack(spacing: 14) {
            ChartHeaderView(chartState: $chartState, earnings: vm.calculateTotalEarnings(from: vm.apptService.appointments))
            // Chart View
            Chart {
                if let selectedDate = vm.selectedDate {
                    RuleMark(x: .value("Selected Day", selectedDate.date, unit: .day))
                        .foregroundStyle(Color(.darkGray).opacity(0.3))
                        .annotation(position: .top, overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
                            ChartAnnotation(date: selectedDate.date, earnings: selectedDate.earnings)
                        }
                }
                ForEach(vm.previousWeekData, id: \.date) { appt in
                    BarMark(
                        x: .value("Date", appt.date, unit: .day),
                        y: .value("Appointment", appt.count)
                    )
                    .foregroundStyle(.icon.gradient)
                    .opacity(vm.rawSelectedDate == nil || appt.date == vm.selectedDate?.date ? 1.0 : 0.3)
                }
            }
            .chartXSelection(value: $vm.rawSelectedDate.animation(.easeInOut))
            .frame(height: 180)
            .chartYAxis(.hidden)
            .chartXAxis {
                AxisMarks { mark in
                    AxisValueLabel()
                }
            }
            ChartPicker(chartState: $chartState)
        }
        .onAppear { vm.appointmentsForLast7days() }
    }
}

#Preview {
    Last7Days(chartState: .constant(.last7Days), selectedOption: .constant(.last7Days))
        .environmentObject(ChartViewModel())
}
