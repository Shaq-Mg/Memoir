//
//  CalenderViewModel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 23/01/2025.
//

import Foundation

final class CalenderViewModel: ObservableObject {
    @Published var availableDays: Set<String> = []
    @Published var selectedMonth = 0
    @Published var currentDate: Date? = nil
    @Published var selectedDate = Date()
    
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    // Generate dates for the current month
    var daysInMonth: [Date] {
           let calendar = Calendar.current
           let range = calendar.range(of: .day, in: .month, for: selectedDate)!
           let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate))!
           
           return range.compactMap { day in
               calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)
           }
       }
    
    // Format calender days
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }
    
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
