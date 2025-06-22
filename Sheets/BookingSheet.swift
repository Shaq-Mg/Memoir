//
//  BookingSheet.swift
//  Memoir
//
//  Created by Shaquille McGregor on 15/06/2025.
//

import SwiftUI

struct BookingSheet: View {
    @State private var appt: Appointment
    
    init(appt: Appointment) {
        _appt = State(initialValue: appt)
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 16) {
                InputDetailView(title: "Serivce", description: appt.description)
                    .padding(.top, 14)
                InputDetailView(title: "Price", description: appt.amount.asCurrencyWith6Decimals())
                InputDetailView(title: "Date", description: appt.date.monthDayYearFormat())
                InputDetailView(title: "Time", description: appt.time.timeFromDate())
            }
            .padding(.horizontal)
            .presentationDetents([.fraction(0.3)])
            .navigationTitle(appt.name)
            .navigationBarTitleDisplayMode(.inline)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    DismissButtonView()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "trash")
                            .font(.headline)
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
