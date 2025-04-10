//
//  BookingCard.swift
//  Memoir
//
//  Created by Shaquille McGregor on 26/01/2025.
//

import SwiftUI

struct BookingCard: View {
    @Binding var isExpanded: Bool
    let appt: Appointment
    
    var body: some View {
        HStack(alignment: .top) {
            Text(appt.name)
            Spacer()
            Image(systemName: isExpanded ? "xmark" : "chevron.down")
        }
        .animation(.snappy, value: isExpanded)
        .font(.system(size: 18, weight: .semibold))
        .foregroundStyle(.natural)
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(.dark).shadow(color: Color(.systemGray3).opacity(0.5), radius: 12, x: 0, y: 0))
    }
}

#Preview {
    BookingCard(isExpanded: .constant(false), appt: Preview.dev.appt1)
}
