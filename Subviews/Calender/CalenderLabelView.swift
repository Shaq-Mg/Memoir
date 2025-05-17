//
//  CalenderLabelView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 15/05/2025.
//

import SwiftUI

struct CalenderLabelView: View {
    var isPast: Bool
    let calender: Calender
    
    var body: some View {
        Text("\(calender.day)")
            .frame(width: 44, height: 44)
            .background(RoundedRectangle(cornerRadius: 10).fill(isPast ? Color(.systemGray4).opacity(0.5) : .accent.opacity(0.8)))
            .foregroundStyle(isPast ? Color(.systemGray) : .white)
    }
}

#Preview {
    CalenderLabelView(isPast: false, calender: Preview.dev.calender)
}
