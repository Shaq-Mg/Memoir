//
//  ApptService.swift
//  Memoir
//
//  Created by Shaquille McGregor on 29/12/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class ApptService {
    @Published var appointments = [Appointment]()
    @Published var services = [Service]()
    
    let appointmentCollection = "appoiontments"
    
    // Fetch upcoming appointments to display in order by date
    func getUpcomingAppointments() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let now = Date()
        FirebaseManager.userDocument(userId: uid).collection(appointmentCollection)
            .whereField(Appointment.CodingKeys.time.rawValue, isGreaterThan: now)
            .order(by: Appointment.CodingKeys.time.rawValue)
            .limit(to: 5)
            .addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching appointments: \(error)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else { return }
                
                self.appointments = documents.compactMap { doc -> Appointment? in
                    let data = doc.data()
                    guard let name = data[Appointment.CodingKeys.name.rawValue] as? String,
                          let description = data[Appointment.CodingKeys.description.rawValue] as? String,
                          let earnings = data[Appointment.CodingKeys.earnings.rawValue] as? Double,
                          let date = data[Appointment.CodingKeys.date.rawValue] as? Timestamp,
                          let time = data[Appointment.CodingKeys.time.rawValue] as? Timestamp else {
                        return nil
                    }
                    return Appointment(name: name, description: description, earnings: earnings, date: date.dateValue(), time: time.dateValue())
                }
            }
    }
    
    // Fetch appointments for a specific date
    func fetchAppointments(for date: Date) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // Start and end of the day
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        FirebaseManager.userDocument(userId: uid).collection(appointmentCollection)
            .whereField(Appointment.CodingKeys.date.rawValue, isGreaterThanOrEqualTo: startOfDay)
            .whereField(Appointment.CodingKeys.date.rawValue, isLessThan: endOfDay)
            .order(by: Appointment.CodingKeys.date.rawValue)
            .getDocuments { [weak self] snapshot, error in
                if let error = error {
                    print("Error fetching appointments: \(error)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No appointments found")
                    return
                }
                
                self?.appointments = documents.compactMap { document in
                    try? document.data(as: Appointment.self)
                }
            }
    }
    
    func fetchAllServices() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Task { services = try await FirebaseManager.fetch(collectionPath: uid, uid: "services", as: Service.self) }
    }
}
