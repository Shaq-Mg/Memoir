//
//  BookingSheet.swift
//  Memoir
//
//  Created by Shaquille McGregor on 27/01/2025.
//

import SwiftUI

struct BookingSheet: View {
    @Environment(\.dismiss) private var dismiss
    let appt: Appointment
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 16) {
                InputDetailView(title: "Serivce", description: appt.description)
                    .padding(.top, 14)
                InputDetailView(title: "Price", description: appt.earnings.asCurrencyWith6Decimals())
                InputDetailView(title: "Date", description: appt.date.monthDayYearFormat())
                InputDetailView(title: "Time", description: appt.time.timeFromDate())
            }
            .padding(.horizontal)
            .presentationDetents([.fraction(0.4)])
            .navigationTitle(appt.name)
            .navigationBarTitleDisplayMode(.inline)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(Color(.systemGray))
                            .fontWeight(.semibold)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        BookingSheet(appt: Preview.dev.appt1)
    }
}
