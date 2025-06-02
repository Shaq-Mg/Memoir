//
//  ChartAnnotation.swift
//  Memoir
//
//  Created by Shaquille McGregor on 24/05/2025.
//

import SwiftUI

struct ChartAnnotation: View {
    let date: Date
    let earnings: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(date.fullMonthDayYearFormat())
                .font(.subheadline).bold()
            
            Text(earnings.asCurrencyWith6Decimals())
                .font(.body)
        }
        .bold()
        .foregroundStyle(Color("AppBackground"))
        .padding(12)
        .frame(width: 120, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 10).fill(.accent.gradient))
    }
}

#Preview {
    ChartAnnotation(date: Date(), earnings: 250)
}
