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
    
    let userCollection = Firestore.firestore().collection("users")
    
    func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    // Fetch appointments for a specific date
    func fetchAppointments(for date: Date) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let startOfDay = Calendar.current.startOfDay(for: date)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        
        userDocument(userId: uid).collection("appointments")
            .whereField(Appointment.CodingKeys.date.rawValue, isGreaterThanOrEqualTo: startOfDay)
            .whereField(Appointment.CodingKeys.date.rawValue, isLessThan: endOfDay)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error fetching appointments: \(error)")
                    return
                }
                
                if let snapshot = snapshot {
                    self.appointments = snapshot.documents.compactMap { document -> Appointment? in
                        try? document.data(as: Appointment.self)
                    }
                }
            }
    }
    
    // Add a new appointment to databse
    func addAppointment(name: String, service: String, date: Date, time: Date) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let newAppointment = Appointment(name: name, service: service, date: date, time: time)
        
        do {
            _ = try userDocument(userId: uid).collection("appointments").addDocument(from: newAppointment)
            fetchAppointments(for: date) // Refresh after adding
        } catch let error {
            print("Error adding appointment: \(error)")
        }
    }
}
