//
//  AppointmentCell.swift
//  Memoir
//
//  Created by Shaquille McGregor on 30/01/2025.
//

import SwiftUI

struct AppointmentCell: View {
    let appt: Appointment
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Circle()
                .foregroundStyle(.icon)
                .frame(width: 10, height: 10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(appt.name)
                    .foregroundStyle(.natural)
                Text(appt.description)
                    .foregroundStyle(.natural.opacity(0.4))
                    .font(.footnote)
            }
            Spacer()
            
            Text(appt.time.timeFromDate())
                .foregroundStyle(.natural.opacity(0.5))
                .font(.footnote)
                .frame(width: 100, alignment: .trailing)
                .minimumScaleFactor(0.6)
                .lineLimit(2)
        }
        .font(.title3).bold()
    }
}

#Preview {
    AppointmentCell(appt: Preview.dev.appt1)
}
