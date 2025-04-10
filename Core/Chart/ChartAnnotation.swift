//
//  ChartAnnotation.swift
//  Memoir
//
//  Created by Shaquille McGregor on 26/01/2025.
//

import SwiftUI

struct ChartAnnotation: View {
    let date: Date
    let earnings: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(date.fullMonthDayYearFormat())
                .font(.subheadline)
            
            Text(earnings, format: .currency(code: Locale.current.currency?.identifier ?? "GBP"))
                .font(.body).italic()
        }
        .bold()
        .foregroundStyle(.dark)
        .padding(12)
        .frame(width: 120, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 10).fill(.icon.gradient))
    }
}

#Preview {
    ChartAnnotation(date: Date(), earnings: 250.00)
}
