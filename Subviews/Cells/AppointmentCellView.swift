//
//  AppointmentCellView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 21/06/2025.
//

import SwiftUI

struct AppointmentCellView: View {
    let appt: Appointment
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Circle()
                .foregroundStyle(.accent)
                .frame(width: 10, height: 10)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(appt.name).bold()
                    .foregroundStyle(Color(.label))
                Text(appt.description)
                    .foregroundStyle(Color(.label).opacity(0.5))
            }
            Spacer()
            
            Text(appt.time.timeFromDate())
                .font(.footnote)
                .foregroundStyle(Color(.label).opacity(0.5))
                .frame(width: 100, alignment: .trailing)
                .minimumScaleFactor(0.6)
                .lineLimit(2)
        }
        .font(.subheadline)
    }
}

#Preview {
    AppointmentCellView(appt: Preview.dev.appt1)
}
