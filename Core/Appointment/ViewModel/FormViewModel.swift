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
    @Published var services = [Service]() // Service array to display in selection sheet
    
    @Published var name = ""
    @Published var selectedSerivce: Service? = nil
    @Published var bookedAppt: Appointment? // Booked appt tot display in booked view
    @Published var showConfirmation = false
    
    var formValidation: Bool {
        return !name.isEmpty && selectedTime != nil && selectedSerivce != nil
    }
    
    private let apptManager = AppointmentManager.shared
    private let calendar = Calendar.current
    
    init() { Task { try await fetchServices() } }
    
    func resetFormInformation() {
        name = ""
        selectedTime = nil
        selectedSerivce = nil
    }
    
    // Fetch services to update array
    func fetchServices() async throws {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        do {
            services = try await apptManager.firebaseManager.fetchAll(userId: userId, collectionPath: "services", orderBy: Service.CodingKeys.title.rawValue)
        } catch {
            print("DEBUG: ERROR fetching serivce \(error.localizedDescription)")
        }
    }
    
    // Book appointment and store to firestore collection
    func bookAppointments(for date: Date) async throws {
        guard let service = selectedSerivce else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let time = selectedTime else { return }
        
        do {
            try await apptManager.book(userId: uid, name: name, description: service.description, for: date, time: time, service: service)
            await loadAvailableTimes(date)
        } catch {
            print("DEBUG: Error storing appointment to backend. \(error.localizedDescription)")
        }
    }
    
    // Load available time slots for date
    func loadAvailableTimes(_ date: Date) async {
        let allSlots = apptManager.generateTimeSlots(date)
        do {
            let booked = try await apptManager.generateBookedTimes(date)
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            DispatchQueue.main.async {
                self.availableTimes = allSlots.filter { slot in
                    !booked.contains(where: {
                        Calendar.current.isDate($0, equalTo: slot, toGranularity: .minute)
                    })
                }
            }
        } catch {
            print("DEBUG: Error fetching appointments. \(error.localizedDescription)")
        }
    }
}
