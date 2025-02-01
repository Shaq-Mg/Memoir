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
        .onAppear {
            vm.apptService.appointments = generateSampleAppointments()
        }
    }
    
    // Function to generate sample appointments for testing
    private func generateSampleAppointments() -> [Appointment] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        return (0..<50).map { _ in
            let randomDayOffset = Int.random(in: 0...6) // Within the next 7 days
            let randomDate = calendar.date(byAdding: .day, value: randomDayOffset, to: today)!
            return Appointment(name: "Lamelo", description: "Haircut", earnings: 20.00, date: randomDate, time: Date.now)
        }
    }
}

#Preview {
    ChartStateView()
        .environmentObject(ChartViewModel())
}
