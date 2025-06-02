//
//  BookingViewModel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 23/05/2025.
//

import FirebaseAuth
import FirebaseFirestore

@MainActor
class BookingViewModel: ObservableObject {
    @Published var selectedDate = Date()
    @Published var selectedTime: Date?
    @Published var availableTimes = [Date]()
    @Published var services = [Service]() // Service array to display in selection sheet
    
    @Published var name = ""
    @Published var selectedSerivce: Service? = nil
    @Published var showConfirmationAlert = false
    
    var formValidation: Bool {
        return !name.isEmpty && selectedTime != nil && selectedSerivce != nil
    }
    
    private let firebaseManager = FirebaseManager.shared
    
    init() { resetFormInformation() }
    
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
    
    func loadAvailableTimes() async {
        let allSlots = generateTimeSlots(for: selectedDate)
        do {
            let booked = try await fetchBookedTimes(for: selectedDate)
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
    
    func bookSelectedTime() async throws {
        guard let service = selectedSerivce else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let time = selectedTime else { return }
        
        do {
            let appt = Appointment(name: name, description: service.title, amount: service.price, date: Calendar.current.startOfDay(for: time), time: time)
            try await firebaseManager.create(appt, userId: uid, collectionPath: "appointments")
            await loadAvailableTimes()
            resetFormInformation()
        } catch {
            print("DEBUG: Error storing appointment to backend. \(error.localizedDescription)")
        }
    }
    
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
