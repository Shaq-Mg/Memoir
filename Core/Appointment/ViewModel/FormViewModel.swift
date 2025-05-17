//
//  FormViewModel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 17/05/2025.
//

import FirebaseAuth
import FirebaseFirestore

@MainActor
final class FormViewModel: ObservableObject {
    @Published var selectedTime: Date? = nil // Selected appointment time
    
    @Published var availableTimes = [Date]() // Available times for the selected date
    @Published var apptsForDate: [Date: [Date]] = [:] // Dictionary to store appointments for dates
    @Published var services = [Service]() // Service array to display in selection sheet
    
    @Published var name = ""
    @Published var selectedSerivce: Service? = nil
    @Published var bookedAppt: Appointment?
    
    private let calendar = Calendar.current
    
    private let manager = AppointmentManager.shared
    
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    init() { Task { try await fetchServices() } }
    
    func removeFormInformation() {
        name = ""
        selectedTime = nil
        selectedSerivce = nil
    }
    
    // Fetch services to update array
    func fetchServices() async throws {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        services = try await manager.fetchAll(userId: userId, collectionPath: "services", orderBy: Service.CodingKeys.title.rawValue)
    }
    
    // Book a new appointment
    func book(for date: Date) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let appt = Appointment(name: name, description: selectedSerivce?.title ?? "", earnings: selectedSerivce?.price ?? 0, date: date, time: selectedTime!)
        try await manager.create(appt, userId: uid, collectionPath: "appointments")
    }
    
    // Generate times for the selected date
    func generateAvailableTimes(_ date: Date) {
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
        if let bookedTimes = apptsForDate[date] {
            times.removeAll(where: { bookedTimes.contains($0) })
        }
        
        availableTimes = times
        selectedTime = availableTimes.first
    }
}
