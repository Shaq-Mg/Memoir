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
    @Published var upcomingAppts = [Appointment]()
    @Published var rawSelectedDate: Date?
    
    var selectedDate: Appointment? {
        guard let rawSelectedDate else { return nil }
        return appointments.first {
            Calendar.current.isDate(rawSelectedDate, equalTo: $0.date, toGranularity: .day)
        }
    }
    
    var previousWeekData: [(date: Date, count: Int)] {
        chartManager.fetchPreviousAppts(appointments)
    }
    
    private let chartManager = ChartManager.shared
    
    init() { Task { try await fetchAppointments() } }
    
    // Fetch appointments to update array for chart UI
    private func fetchAppointments() async throws {
        do {
            appointments = try await chartManager.fetchAppointments()
        } catch {
            print("DEBUG: ERROR fetching appointments \(error.localizedDescription)")
        }
    }
    
    // Fetch upcoming appointments for chart view
    func fetchUpcomingAppointments() {
        Task { self.upcomingAppts = try await chartManager.getUpcomingAppts() }
    }
    
    // Function to group appointments by day and calculate daily counts
    func fetchDailyChartAppts(from startDate: Date) -> [(date: Date, count: Int, earnings: Double)] {
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
    
    // Function to Calculate Total Earnings (Next 7 Days)
    func totalEarningsNext7Days() -> Double {
        chartManager.getNext7DaysEarnings(appointments)
    }
    
    // Function to Calculate Total Earnings (Last 7 Days)
    func totalEarningsLast7Days() -> Double {
        chartManager.getLast7DaysEarnings(appointments)
    }
    
    func fetchLast7daysData() {
        Task { try await fetchAppointments() }
        Task { appointments = try await chartManager.generateDailyEarnings(value: -7) }
    }
    
    func fetchNext7daysData() {
        Task { try await fetchAppointments() }
        Task { appointments = try await  chartManager.generateDailyEarnings(value: 7) }
    }
}
