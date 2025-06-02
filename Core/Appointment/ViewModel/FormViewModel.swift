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
    @Published var showConfirmationAlert = false
    
    var formValidation: Bool {
        return !name.isEmpty && selectedTime != nil && selectedSerivce != nil
    }
    
    private let firebaseManager = FirebaseManager.shared
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
            services = try await firebaseManager.fetchAll(userId: userId, collectionPath: "services", orderBy: Service.CodingKeys.title.rawValue)
        } catch {
            print("DEBUG: ERROR fetching serivce \(error.localizedDescription)")
        }
    }
    
    // Book appointment and store to firestore collection
    func book(for date: Date) async throws {
        guard let service = selectedSerivce else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let time = selectedTime else { return }
        
        do {
            let appt = Appointment(name: name, description: service.title, amount: service.price, date: Calendar.current.startOfDay(for: time), time: time)
            try await firebaseManager.create(appt, userId: uid, collectionPath: "appointments")
            await loadAvailableTimes(date)
        } catch {
            print("DEBUG: Error storing appointment to backend. \(error.localizedDescription)")
        }
    }
    
    // Load available time slots for date
    func loadAvailableTimes(_ date: Date) async {
        let allSlots = generateTimeSlots(for: date)
        do {
            let booked = try await fetchBookedTimes(for: date)
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
    
    // Fetch booked time slots to remove from appts array
    func fetchBookedTimes(for date: Date) async throws -> [Date] {
        guard let uid = Auth.auth().currentUser?.uid else { return [] }
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let snapshot = try await FirebaseConstants.collectionPath(userId: uid, collectionId: "appointments")
            .whereField("time", isGreaterThanOrEqualTo: Timestamp(date: startOfDay))
            .whereField("time", isLessThan: Timestamp(date: endOfDay))
            .getDocuments()
        
        let booked = snapshot.documents.compactMap { doc in
            let timestamp = doc["time"] as? Timestamp
            return timestamp?.dateValue()
        }
        
        return booked
    }
    
    // Generate time slots from 6am - 10pm for the selected date
    func generateTimeSlots(for date: Date) -> [Date] {
        var slots: [Date] = []
        let calendar = Calendar.current
        var start = calendar.date(bySettingHour: 6, minute: 0, second: 0, of: date)!
        let end = calendar.date(bySettingHour: 22, minute: 0, second: 0, of: date)!
        
        while start <= end {
            slots.append(start)
            start = calendar.date(byAdding: .minute, value: 15, to: start)!
        }
        return slots
    }
}
