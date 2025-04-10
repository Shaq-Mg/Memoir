//
//  ChartHeaderView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 26/01/2025.
//

import SwiftUI

struct ChartHeaderView: View {
    @Binding var chartState: ChartState
    let earnings: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(chartState.rawValue)
                .font(.system(size: 24, weight: .semibold))
            
            HStack {
                Text("Total:")
                Text(earnings, format: .currency(code: Locale.current.currency?.identifier ?? "GBP"))
            }
            .foregroundStyle(.natural.opacity(0.5))
            .font(.system(size: 16, weight: .bold))
        }
        .italic()
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding([.leading, .bottom])
    }
}

#Preview {
    ChartHeaderView(chartState: .constant(.last7Days), earnings: 200.00)
}
