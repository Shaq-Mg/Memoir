//
//  CalenderViewModel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 15/05/2025.
//

import Foundation

@MainActor
final class CalenderViewModel: ObservableObject {
    @Published var availableDays: Set<String> = []
    @Published var selectedMonth = 0
    @Published var currentDate: Date?
    @Published var selectedDate = Date()
    
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    // Format schedule days
    func fetchDates() -> [Calender] {
        let calender = Calendar.current
        let currentMonth = fetchSelectedMonth()
        
        var dates = currentMonth.datesOfMonth().map({ Calender(day: calender.component(.day, from: $0), date: $0) })
        
        let firstDayOfWeek = calender.component(.weekday, from: dates.first?.date ?? Date())
        
        for _ in 0..<firstDayOfWeek - 1 {
            dates.insert(Calender(day: -1, date: Date()), at: 0)
        }
        
        return dates
    }
    
    func fetchSelectedMonth() -> Date {
        let calender = Calendar.current
        
        let month = calender.date(byAdding: .month, value: selectedMonth, to: Date())
        return month!
    }
    
    // Method to check if the previous month should be disabled
    func isPreviousMonthDisabled() -> Bool {
        let current = Calendar.current.dateComponents([.month, .year], from: Date())
        let selected = Calendar.current.dateComponents([.month, .year], from: selectedDate)
        
        // Disable if the selected month and year are equal to or before the current month and year
        return selected.year! <= current.year! && selected.month! <= current.month!
    }
}
