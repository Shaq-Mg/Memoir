//
//  DayView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 30/01/2025.
//

import SwiftUI

struct DayView: View {
    @EnvironmentObject var apptVM: ApptViewModel
    @Binding var showSideMenu: Bool
    @State private var showDeleteAction = false
    var currentDate: Date
    
    var body: some View {
        VStack {
            MainHeaderView(showSideMenu: $showSideMenu, onDismiss: true, title: currentDate.dayOfTheWeek())
            if apptVM.dataService.appointments.isEmpty {
                ScrollView(showsIndicators: false) {
                    ContentUnavailableView("No Appointments Today", systemImage: "book.pages", description: Text("Schedule appointments for current date."))
                }
            } else {
                List(apptVM.dataService.appointments)  { appt in
                    Button {
                        showDeleteAction.toggle()
                    } label: {
                        AppointmentCell(appt: appt)
                    }
                    .confirmationDialog("Delete", isPresented: $showDeleteAction, titleVisibility: .visible) {
                        Button("Yes", role: .destructive) {
                            apptVM.delete(apptToDelete: appt)
                        }
                    } message: {
                        Text("Are you sure that you want to delete this appointment?")
                    }
                }
                .listStyle(.plain)
                .onAppear {
                    apptVM.fetchAppointments(for: currentDate)
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DayView(showSideMenu: .constant(false), currentDate: Date())
            .environmentObject(ApptViewModel())
    }
}
