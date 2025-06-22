//
//  AppointmentSheet.swift
//  Memoir
//
//  Created by Shaquille McGregor on 21/06/2025.
//

import SwiftUI

struct AppointmentSheet: View {
    @EnvironmentObject private var viewModel: DayViewModel
    @State private var appt: Appointment
    @State private var showDeleteConfirmation = false
    
    init(appt: Appointment) {
        _appt = State(initialValue: appt)
    }
    
    var body: some View {
        Form {
            Text(appt.name)
            Text(appt.description)
        }
        .navigationTitle(appt.time.timeFromDate())
        .navigationBarTitleDisplayMode(.inline)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .presentationDetents([.fraction(0.25)])
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                DismissButtonView()
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showDeleteConfirmation.toggle()
                } label: {
                    Image(systemName: "trash")
                        .font(.headline)
                }
            }
        }
        .alert("Delete Appointment", isPresented: $showDeleteConfirmation, actions: {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) { viewModel.delete(appt) }
        })
    }
}

#Preview {
    AppointmentSheet(appt: Preview.dev.appt1)
}
