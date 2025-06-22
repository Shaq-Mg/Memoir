//
//  DayView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 21/06/2025.
//

import SwiftUI

struct DayView: View {
    @StateObject private var viewModel = DayViewModel()
    @State private var showApptSheet = false
    var currentDate: Date
    
    var body: some View {
        VStack {
            DismissHeaderView(title: currentDate.dayOfTheWeek())
            if viewModel.appointments.isEmpty {
                ScrollView(showsIndicators: false) {
                    LoadingView(title: "No appointments scheduled for date")
                        .padding(.top, 72)
                }
            } else {
                List(viewModel.appointments)  { appt in
                    Button {
                        showApptSheet.toggle()
                    } label: {
                        AppointmentCellView(appt: appt)
                    }
                    .sheet(isPresented: $showApptSheet) {
                        AppointmentSheet(appt: appt)
                    }
                }
                .listStyle(.plain)
                .navigationBarBackButtonHidden()
            }
        }
        .onAppear {
            Task { try await viewModel.fetchAppointments(currentDate) }
        }
    }
}

#Preview {
    NavigationStack {
        DayView(currentDate: Date())
            .environmentObject(DayViewModel())
    }
}
