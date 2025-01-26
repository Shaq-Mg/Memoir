//
//  ExpandableBookingView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 26/01/2025.
//

import SwiftUI

struct ExpandableBookingView: View {
    @EnvironmentObject private var vm: ApptViewModel
    @State private var visibleAppts = [Appointment]()
    @Binding var currentDate: Date
    
    var body: some View {
        VStack(spacing: 14) {
            
            if vm.dataService.appointments.isEmpty {
                ContentUnavailableView("No appointments available", systemImage: "calendar.badge.clock", description: Text("Please book appoitments"))
            } else {
                ScrollView(showsIndicators: false) {
                    ForEach(vm.dataService.appointments) { appt in
                        NavigationLink {
                            
                        } label: {
                            BookingCard(appt: appt)
                        }
                        .scaleEffect(visibleAppts.contains(appt) ? 1.0 : 0.8)
                        .opacity(visibleAppts.contains(appt) ? 1.0 : 0.5)
                    }
                    .onScrollTargetVisibilityChange(idType: Appointment.self, threshold: 0.3) { appt in
                        self.visibleAppts = appt
                    }
                }
                Text(currentDate.fullMonthDayYearFormat())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color(.systemGray)).bold()
                    .padding(.top, 12)
            }
        }
        .onAppear(perform: vm.fetchUpcomingAppointments)
    }
}

#Preview {
    ExpandableBookingView(currentDate: .constant(Date()))
        .environmentObject(ApptViewModel())
}
