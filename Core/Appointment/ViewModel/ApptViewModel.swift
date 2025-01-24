//
//  ApptViewModel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 29/12/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

@MainActor
final class ApptViewModel: ObservableObject {
    @Published var selectedDate = Date()
    @Published var selectedTime: Date? = nil // Selected appointment time
    @Published var availableTimes: [Date] = [] // Available times for the selected date
    @Published var appointments: [Date: [Date]] = [:] // Dictionary to store appointments for dates

    @Published var appointment: Appointment? = nil
    @Published var selectedSerivce: Service? = nil
    @Published var name = ""
    
    private var cancellables = Set<AnyCancellable>()
    private let calendar = Calendar.current
    
    let service = AuthService.shared
    let dataService = ApptService()
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    // Fetch upcoming appointments to display in order by date
    func fetchUpcomingAppointments() {
        dataService.getUpcomingAppointments()
    }
    
    // Fetch appointments for a specific date
    func fetchAppointments(for date: Date) {
        dataService.fetchAppointments(for: date)
    }
    
    // Book a new appointment
    func book(name: String, description: String, price: Double, date: Date, time: Date) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let newAppointment = Appointment(name: name, description: description, earnings: price, date: date, time: time)
        
        do {
            _ = try FirebaseManager.userDocument(userId: uid).collection(dataService.appointmentCollection).addDocument(from: newAppointment)
            fetchAppointments(for: date) // Refresh after adding
            
            generateAvailableTimes(for: selectedDate)  // Refresh available times
            
            selectedTime = nil // Reset selection
        } catch let error {
            print("Error adding appointment: \(error)")
        }
    }
    
    func delete(apptToDelete: Appointment) {
        guard let uid = service.userSession?.uid else { return }
        FirebaseManager.userDocument(userId: uid).collection(dataService.appointmentCollection).document(apptToDelete.id ?? "").delete { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.dataService.appointments.removeAll { appt in
                        return appt.id == apptToDelete.id
                    }
                }
                self.fetchAppointments(for: apptToDelete.time)
            } else {
                // handle error here
                print("Failed to delete client to firestore")
            }
        }
    }
    
    // Generate times for the selected date
    func generateAvailableTimes(for date: Date) {
        let startTime = calendar.date(bySettingHour: 8, minute: 0, second: 0, of: date)!
        let endTime = calendar.date(bySettingHour: 22, minute: 0, second: 0, of: date)!
        
        // Generate 15-minute intervals
        var times: [Date] = []
        var currentTime = startTime
        
        while currentTime <= endTime {
            times.append(currentTime)
            currentTime = calendar.date(byAdding: .minute, value: 15, to: currentTime)!
        }
        
        // Filter out already booked times
        if let bookedTimes = appointments[date] {
            times.removeAll(where: { bookedTimes.contains($0) })
        }
        
        availableTimes = times
        selectedTime = availableTimes.first
    }
}
