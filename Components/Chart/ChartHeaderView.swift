//
//  ChartHeaderView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 24/05/2025.
//

import SwiftUI

struct ChartHeaderView: View {
    @Binding var chartState: ChartState
    let earnings: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(chartState.rawValue)
                .font(.title3)
                .fontWeight(.semibold)
            
            HStack {
                Text("Total:")
                Text(earnings.asCurrencyWith6Decimals())
            }
            .foregroundStyle(Color(.label).opacity(0.4))
            .font(.title3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding([.leading, .bottom])
    }
}

#Preview {
    ChartHeaderView(chartState: .constant(.last7Days), earnings: 200)
}
