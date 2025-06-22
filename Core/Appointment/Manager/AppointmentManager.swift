//
//  AppointmentManager.swift
//  Memoir
//
//  Created by Shaquille McGregor on 17/05/2025.
//

import FirebaseAuth
import FirebaseFirestore

class AppointmentManager {
    
    static let shared = AppointmentManager()
    let firebaseManager = FirebaseManager.shared
    
    private let apptCollection = "appointments"
    
    private init() { }
    
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    // Book appointment and store to firestore collection
    func book(userId: String, name: String, description: String, for date: Date, time: Date, service: Service?) async throws {
        let appt = Appointment(name: name, description: service?.title ?? "", amount: service?.price ?? 0, date: Calendar.current.startOfDay(for: time), time: time)
        try await firebaseManager.create(appt, userId: userId, collectionPath: apptCollection)
    }
    
    // Fetch appointments to display for day view
    func getAppointments(for date: Date) async throws -> [Appointment] {
        guard let uid = Auth.auth().currentUser?.uid else { return [] }
        // Start and end of the day
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let snapshot = try await FirebaseConstants.collectionPath(userId: uid, collectionId: apptCollection)
            .whereField(Appointment.CodingKeys.date.rawValue, isGreaterThanOrEqualTo: startOfDay)
            .whereField(Appointment.CodingKeys.date.rawValue, isLessThan: endOfDay)
            .order(by: Appointment.CodingKeys.date.rawValue)
            .getDocuments()
        return try snapshot.documents.compactMap { try $0.data(as: Appointment.self) }
    }
    
    func fetchAppointmentsForEarnings(value: Int) async throws -> [Appointment] {
        guard let uid = Auth.auth().currentUser?.uid else { return [] }
        
        let calendar = Calendar.current
        let dateRange = calendar.date(byAdding: .day, value: value, to: Date()) ?? Date()
        
        let querySnapshot = try await  FirebaseConstants.userDocument(userId: uid).collection(apptCollection)
            .whereField("date", isGreaterThanOrEqualTo: dateRange)
            .order(by: "date", descending: true)
            .getDocuments()
        
        return try querySnapshot.documents.compactMap { doc in
            try doc.data(as: Appointment.self)
        }
    }
    
    // Fetch booked time slots to remove from appts array
    func generateBookedTimes(_ date: Date) async throws -> [Date] {
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
    func generateTimeSlots(_ date: Date) -> [Date] {
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
