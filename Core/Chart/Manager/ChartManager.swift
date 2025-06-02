//
//  ChartManager.swift
//  Memoir
//
//  Created by Shaquille McGregor on 24/05/2025.
//

import FirebaseAuth
import FirebaseFirestore

final class ChartManager {
    
    static let apptCollection = "appointments"
    static let firebaseManager = FirebaseManager.shared
    
    private init() { }
    
    // Function to fetch all appointments
    static func fetchAppointments() async throws -> [Appointment] {
        guard let uid = Auth.auth().currentUser?.uid else { return [] }
        let snapshot = try await FirebaseConstants.collectionPath(userId: uid, collectionId: apptCollection).getDocuments()
        return try snapshot.documents.compactMap { try $0.data(as: Appointment.self) }
    }
    
    // Function to Calculate Appointment Counts for the Previous 7 Days
    static func fetchPreviousAppts(_ appts: [Appointment]) -> [(date: Date, count: Int)] {
        let today = Calendar.current.startOfDay(for: Date())
        let last7Days = (0..<7).map { Calendar.current.date(byAdding: .day, value: -$0, to: today)! }
        
        return last7Days.map { day in
            let count = appts.filter { Calendar.current.isDate($0.date, inSameDayAs: day) }.count
            return (day, count)
        }.sorted { $0.date < $1.date }
    }
    
    // Fetch appointments to display daily earnings for chart date
    static func generateDailyEarnings(value: Int) async throws -> [Appointment] {
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
    
    // Function to generate earnings for chart header
    static func generateTotalEarnings(value: Int) async throws -> [Appointment] {
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
}
