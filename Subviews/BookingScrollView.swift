//
//  BookingScrollView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 15/06/2025.
//

import SwiftUI

struct BookingScrollView: View {
    @StateObject var viewModel: ChartViewModel
    @State private var selectedItem: Appointment?
    @State private var isSelected = false
    @Binding var currentDate: Date
    
    var body: some View {
        VStack {
            if viewModel.upcomingAppts.isEmpty {
                LoadingView(title: "No appointments scheduled")
            } else {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.upcomingAppts) { appt in
                        Button {
                            selectedItem = appt
                            isSelected.toggle()
                        } label: {
                            BookingCard(selectedItem: $selectedItem, appt: appt)
                        }
                        .scaleEffect(selectedItem == appt ? 1.0 : 0.9)
                        .sheet(isPresented: $isSelected) {
                            NavigationStack {
                                BookingSheet(appt: appt)
                            }
                        }
                    }
                }
            }
        }
        .onAppear { viewModel.fetchUpcomingAppointments() }
    }
}

#Preview {
    BookingScrollView(viewModel: ChartViewModel(), currentDate: .constant(Date()))
}
