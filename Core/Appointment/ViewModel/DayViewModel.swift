//
//  DayViewModel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 21/06/2025.
//

import FirebaseAuth
import FirebaseFirestore

@MainActor
final class DayViewModel: ObservableObject {
    @Published var appointments = [Appointment]()
    
    private let apptManager = AppointmentManager.shared
    
    func fetchAppointments(_ date: Date) async throws {
        do {
            self.appointments = try await apptManager.getAppointments(for: date)
        } catch {
            print("DEBUG: Failed to fetch appts for date \(error.localizedDescription)" )
        }
    }
    
    func delete(_ apptToDelete: Appointment) {
        appointments.removeAll { $0.id == apptToDelete.id }
    }
}

