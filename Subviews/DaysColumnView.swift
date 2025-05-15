//
//  DaysColumnView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 15/05/2025.
//

import SwiftUI

struct DaysColumnView: View {
    let day: String
    var body: some View {
        Text(day)
            .font(.system(size: 20, weight: .semibold))
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity)
            .padding(.bottom, 12)
    }
}

#Preview {
    DaysColumnView(day: "Mon")
}
