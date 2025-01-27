//
//  BookingScrollView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 26/01/2025.
//

import SwiftUI

struct BookingScrollView: View {
    @EnvironmentObject private var vm: ApptViewModel
    @State private var isSelected = false
    @Binding var currentDate: Date
    
    var body: some View {
        VStack {
            if vm.dataService.appointments.isEmpty {
                ContentUnavailableView("No appointments available", systemImage: "calendar.badge.clock", description: Text("You have no appointments scheduled for todays date."))
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 14) {
                        ForEach(vm.dataService.appointments) { appt in
                            Button {
                                isSelected.toggle()
                            } label: {
                                BookingCard(isExpanded: $isSelected, appt: appt)
                            }
                            .sheet(isPresented: $isSelected) {
                                NavigationStack {
                                    BookingSheet(appt: appt)
                                }
                            }
                        }
                    }
                    .safeAreaPadding()
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.paging)
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
    BookingScrollView(currentDate: .constant(Date()))
        .environmentObject(ApptViewModel())
}
