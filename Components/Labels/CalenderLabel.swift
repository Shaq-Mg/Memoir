//
//  CalenderLabel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 23/01/2025.
//

import SwiftUI

struct CalenderLabel: View {
    let day: Int
    let date: Date
    
    var body: some View {
        Text("\(day)")
            .bold()
            .foregroundStyle(date.monthDayYearFormat() == Date().monthDayYearFormat() ? .white : .black)
            .background(
                ZStack(alignment: .bottom) {
                    Circle()
                        .frame(width: 34, height: 34)
                        .foregroundStyle(.clear)
                    ZStack {
                        if date.monthDayYearFormat() == Date().monthDayYearFormat() {
                            Circle()
                                .frame(width: 36, height: 36)
                                .foregroundStyle(.icon)
                                .shadow(radius: 1)
                        }
                    }
                })
    }
}

#Preview {
    CalenderLabel(day: 2, date: Date())
}
