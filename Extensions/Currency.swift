//
//  Currency.swift
//  Memoir
//
//  Created by Shaquille McGregor on 24/05/2025.
//

import Foundation

extension Double {
    
    ///: Converts a Double into a Currency with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to £1.234.56
    /// ```
    private var  currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.maximumFractionDigits = 6
        formatter.minimumFractionDigits = 2
        return formatter
    }
    
    /// Converts a Double into a Currency as a string with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to "£1.234.56"
    /// ```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "£0.00"
    }
    
    /// Converts a Double into String representation
    /// ```
    /// Convert 1234.56 to "1.23"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Converts a Double into String representation with percent symbol
    /// ```
    /// Convert 1234.56 to "1.23%"
    /// ```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
}
