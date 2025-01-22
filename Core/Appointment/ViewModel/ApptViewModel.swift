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
    @Published var selectedTime: Date? = nil
    @Published var selectedDate = Date()
    @Published var services = [Service]()
    
    @Published var name = ""
    @Published var title = ""
    
    @Published var appointment: Appointment? = nil
    @Published var service: Service? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let apptService: ApptService
    let dataService = AuthService.shared
    
    init(apptService: ApptService) {
        self.apptService = apptService
        
        $selectedDate
            .sink { date in
                self.apptService.fetchAppointments(for: date)
            }
            .store(in: &cancellables)
    }
    
    func update(apptToUpdate: Appointment) {
        guard let uid = dataService.userSession?.uid else { return }
        FirebaseManager.userCollection.document(uid).collection("appointments").document(apptToUpdate.id ?? "").setData(["name": apptToUpdate.name, "title": apptToUpdate.service, "time": apptToUpdate.date], merge: true)
    }
    
    // Delete appointment from backend
    func delete(apptToDelete: Appointment) {
        guard let uid = dataService.userSession?.uid else { return }
        apptService.userDocument(userId: uid).collection("appointments").document(apptToDelete.id ?? "").delete { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.apptService.appointments.removeAll { appt in
                        return appt.id == apptToDelete.id
                    }
                }
                self.apptService.fetchAppointments(for: apptToDelete.date)
            } else {
                // handle error here
                print("Failed to delete client to firestore")
            }
        }
    }
    
    // Fetch services from backend
    func fetchServiceForAppt() {
        guard let uid = dataService.userSession?.uid else { return }
        FirebaseManager.userDocument(userId: uid).collection("services").order(by: Service.CodingKeys.title.rawValue) // Optional: sort by a field
            .addSnapshotListener { [weak self] (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents found")
                    return
                }
                
                self?.services = documents.compactMap({ try? $0.data(as: Service.self) })
            }
    }
}
