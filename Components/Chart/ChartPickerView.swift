//
//  ChartPickerView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 24/05/2025.
//

import SwiftUI

struct ChartPickerView: View {
    @Binding var chartState: ChartState
    
    var body: some View {
        Picker("", selection: $chartState) {
            ForEach(ChartState.allCases) { value in
                Text(value.rawValue)
                    .tag(value)
                    .onTapGesture {
                        withAnimation(.easeIn) {
                            chartState = value
                        }
                    }
            }
        }
        .tint(Color(.darkGray))
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

#Preview {
    ChartPickerView(chartState: .constant(.next7Days))
}
