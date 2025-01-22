//
//  ChartState.swift
//  Memoir
//
//  Created by Shaquille McGregor on 29/12/2024.
//

import Foundation

enum ChartState: String, Identifiable, CaseIterable {
    case currentWeek = "Current week"
    case previousWeek = "Previous week"
    case currentMonth = "Current month"
    case previousMonth = "Previous month"
    case currentYear = "Current year"
    case previousYear = "Previous year"
    
    var id: String {
        return rawValue
    }
}
