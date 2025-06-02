//
//  ChartViewModel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 02/06/2025.
//

import Foundation

@MainActor
final class ChartViewModel: ObservableObject {
    @Published var appointments = [Appointment]()
    @Published var rawSelectedDate: Date?
    
    var selectedDate: Appointment? {
        guard let rawSelectedDate else { return nil }
        return appointments.first {
            Calendar.current.isDate(rawSelectedDate, equalTo: $0.date, toGranularity: .day)
        }
    }
    
    var previousWeekData: [(date: Date, count: Int)] {
        ChartManager.fetchPreviousAppts(appointments)
    }
    
    init() {
        Task { try await fetchAppointments() }
    }
    
    // Fetch appointments to update array for chart UI
    private func fetchAppointments() async throws {
        do {
            appointments = try await ChartManager.fetchAppointments()
        } catch {
            print("DEBUG: ERROR fetching appointments \(error.localizedDescription)")
        }
    }
    
    // Function to group appointments by day and calculate daily counts
    func fetchUpcomingAppts(from startDate: Date) -> [(date: Date, count: Int, earnings: Double)] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: startDate)
        
        return (0..<7).map { dayOffset in
            let day = calendar.date(byAdding: .day, value: dayOffset, to: startOfDay)!
            let dailyAppointments = appointments.filter {
                calendar.isDate($0.date, inSameDayAs: day)
            }
            let earnings = dailyAppointments.reduce(0) { $0 + $1.amount }
            return (date: day, count: dailyAppointments.count, earnings: earnings)
        }
    }
    
    func calculateTotalEarnings(from appts: [Appointment]) -> Double {
        appts.reduce(0) { $0 + $1.amount }
    }
    
    func generateLast7daysEarnings() {
        Task { appointments = try await ChartManager.generateDailyEarnings(value: -7) }
    }
    
    func generateNext7daysEarnings() {
        Task { appointments = try await  ChartManager.generateDailyEarnings(value: 7) }
    }
}
