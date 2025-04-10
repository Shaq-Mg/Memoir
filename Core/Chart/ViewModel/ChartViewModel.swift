//
//  ChartViewModel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 26/01/2025.
//

import Foundation

@MainActor
final class ChartViewModel: ObservableObject {
    @Published var rawSelectedDate: Date?
    
    let apptService = ApptService.shared
    
    var selectedDate: Appointment? {
        guard let rawSelectedDate else { return nil }
        return apptService.appointments.first {
            Calendar.current.isDate(rawSelectedDate, equalTo: $0.date, toGranularity: .day)
        }
    }
    
    var previousWeekData: [(date: Date, count: Int)] {
        fetchLast7Days(appts: apptService.appointments)
    }
    
    // Function to Calculate Appointment Counts for the Previous 7 Days
    func fetchLast7Days(appts: [Appointment]) -> [(date: Date, count: Int)] {
        let today = Calendar.current.startOfDay(for: Date())
        let last7Days = (0..<7).map { Calendar.current.date(byAdding: .day, value: -$0, to: today)! }
        
        return last7Days.map { day in
            let count = appts.filter { Calendar.current.isDate($0.date, inSameDayAs: day) }.count
            return (day, count)
        }.sorted { $0.date < $1.date }
    }
    
    // Function to group appointments by day and calculate daily counts
    func fetchNext7Days(from startDate: Date) -> [(date: Date, count: Int, earnings: Double)] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: startDate)
        
        return (0..<7).map { dayOffset in
            let day = calendar.date(byAdding: .day, value: dayOffset, to: startOfDay)!
            let dailyAppointments = apptService.appointments.filter {
                calendar.isDate($0.date, inSameDayAs: day)
            }
            let earnings = dailyAppointments.reduce(0) { $0 + $1.earnings }
            return (date: day, count: dailyAppointments.count, earnings: earnings)
        }
    }
    
    func calculateTotalEarnings(from appts: [Appointment]) -> Double {
        appts.reduce(0) { $0 + $1.earnings }
    }
    
    func appointmentsForLast7days() {
        Task {
            apptService.appointments = try await apptService.fetchAppointmentsForEarnings(value: -7)
        }
    }
    
    func appointmentsForNext7days() {
        Task {
            apptService.appointments = try await apptService.fetchAppointmentsForEarnings(value: 7)
        }
    }
}
