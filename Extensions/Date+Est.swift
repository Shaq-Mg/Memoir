//
//  Date+Est.swift
//  Memoir
//
//  Created by Shaquille McGregor on 15/05/2025.
//

import Foundation

extension Date {

    static func from(year: Int, month: Int, day: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components) ?? Date()
    }
    
    // Generate dates of the month
    func datesOfMonth() -> [Date] {
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: self)
        let currentYear = calendar.component(.year, from: self)
        
        var startDateComponents = DateComponents()
        startDateComponents.year = currentYear
        startDateComponents.month = currentMonth
        startDateComponents.day = 1
        let startDate = calendar.date(from: startDateComponents)!
        
        var endDateComponents = DateComponents()
        endDateComponents.month = 1
        endDateComponents.day = -1
        let endDate = calendar.date(byAdding: endDateComponents, to: startDate)!
        
        var dates: [Date] = []
        var currentDate = startDate
        
        while currentDate <= endDate {
            dates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        return dates
    }
    
    // Returns date as August 2023
    func monthYearFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: self)
    }
    
    // Returns date as 08/23/2023
    func monthDayYearFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: self)
    }
    
    // Returns date as Tuesday, August 23, 2025
    func fullMonthDayYearFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM dd, yyyy"
        return formatter.string(from: self)
    }
    
    // Returns date as Saturday 14
    func dayOfTheWeek() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE dd"
        return formatter.string(from: self)
    }
    
    // Returns date as 14:30 PM
    func timeFromDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: self)
    }
    
    // Returns date as ex: 13:00 pm - 13:30 pm, Thursday, January 16, 2025
    func dayViewDateFormat() -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        let start = timeFormatter.string(from: self)
        
        let endDate = Calendar.current.date(byAdding: .minute, value: 30, to: self)!
        let end = timeFormatter.string(from: endDate)
        
        let day = self.dayOfTheWeek()
        let fullDateString = self.monthYearFormat()
        return "\(start) - \(end), \(day), \(fullDateString)"
        
    }
    
    // Returns date as ex: 13:00PM - 13:30PM, Thursday
    func timeForDayFormat() -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        let start = timeFormatter.string(from: self)
        
        let endDate = Calendar.current.date(byAdding: .minute, value: 30, to: self)!
        let end = timeFormatter.string(from: endDate)
        
        let day = self.dayOfTheWeek()
        return "\(start) - \(end), \(day)"
        
    }
    
    // Date formatter for X-axis labels
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter
    }
}
