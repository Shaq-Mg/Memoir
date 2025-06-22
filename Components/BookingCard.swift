//
//  BookingCard.swift
//  Memoir
//
//  Created by Shaquille McGregor on 15/06/2025.
//

import SwiftUI

struct BookingCard: View {
    @Binding var selectedItem: Appointment?
    let appt: Appointment
    
    var body: some View {
        HStack {
            Text(appt.name)
                .frame(maxWidth: .infinity, alignment: .center)
            Spacer()
            Image(systemName: "chevron.down")
                .font(.subheadline)
                .foregroundStyle(Color(.darkGray))
        }
        .animation(.snappy, value: selectedItem)
        .scaleEffect(selectedItem == appt ? 1.0 : 0.9)
        .font(.headline)
        .foregroundStyle(Color(.label))
        .padding(10)
        .background(Color(.offWhite))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.systemGray4), lineWidth: 1))
    }
}

#Preview {
    BookingCard(selectedItem: .constant(Preview.dev.appt1), appt: Preview.dev.appt1)
}
