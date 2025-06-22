//
//  ChartManager.swift
//  Memoir
//
//  Created by Shaquille McGregor on 24/05/2025.
//

import FirebaseAuth
import FirebaseFirestore

final class ChartManager {
    static let shared = ChartManager()
    
    private init() { }
    
    private let apptCollection = "appointments"
    private let firebaseManager = FirebaseManager.shared
    
    // Fetch upcoming appointments for chart view to display in order by date
    func getUpcomingAppts() async throws -> [Appointment] {
        guard let uid = Auth.auth().currentUser?.uid else { return [] }
        let now = Date()
        let snapshot = try await FirebaseConstants.collectionPath(userId: uid, collectionId: apptCollection)
            .whereField(Appointment.CodingKeys.time.rawValue, isGreaterThan: now)
            .order(by: Appointment.CodingKeys.time.rawValue)
            .limit(to: 5).getDocuments()
        return try snapshot.documents.compactMap { try $0.data(as: Appointment.self) }
    }
    
    // Function to fetch all appointments
    func fetchAppointments() async throws -> [Appointment] {
        guard let uid = Auth.auth().currentUser?.uid else { return [] }
        let snapshot = try await FirebaseConstants.collectionPath(userId: uid, collectionId: apptCollection).getDocuments()
        return try snapshot.documents.compactMap { try $0.data(as: Appointment.self) }
    }
    
    // Function to Calculate Appointment Counts for the Previous 7 Days
    func fetchPreviousAppts(_ appts: [Appointment]) -> [(date: Date, count: Int)] {
        let today = Calendar.current.startOfDay(for: Date())
        let last7Days = (0..<7).map { Calendar.current.date(byAdding: .day, value: -$0, to: today)! }
        
        return last7Days.map { day in
            let count = appts.filter { Calendar.current.isDate($0.date, inSameDayAs: day) }.count
            return (day, count)
        }.sorted { $0.date < $1.date }
    }
    
    // Fetch appointments to display daily earnings for chart date
    func generateDailyEarnings(value: Int) async throws -> [Appointment] {
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
    func generateTotalEarnings(value: Int) async throws -> [Appointment] {
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

extension ChartManager {
    func getNext7DaysEarnings(_ appts: [Appointment]) -> Double {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        guard let endDate = calendar.date(byAdding: .day, value: 7, to: today) else { return 0.0 }
        
        let earnings = appts
            .filter { appointment in
                guard let appointmentDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: appointment.date) else {
                    return false
                }
                return appointmentDate >= today && appointmentDate < endDate
            }
            .reduce(0) { $0 + $1.amount }
        
        return earnings
    }
    
    func getLast7DaysEarnings(_ appts: [Appointment]) -> Double {
        let calendar = Calendar.current
        let now = Date()
        guard let sevenDaysAgo = calendar.date(byAdding: .day, value: -7, to: now) else {
            return 0.0
        }
        
        let recentAppointments = appts.filter {
            $0.date >= sevenDaysAgo && $0.date <= now
        }
        
        let total = recentAppointments.reduce(0.0) { $0 + $1.amount }
        return total
    }
}
