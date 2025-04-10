//
//  ChartPicker.swift
//  Memoir
//
//  Created by Shaquille McGregor on 26/01/2025.
//

import SwiftUI

struct ChartPicker: View {
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
    ChartPicker(chartState: .constant(.next7Days))
}
