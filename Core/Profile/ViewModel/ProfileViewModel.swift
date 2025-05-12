//
//  ProfileViewModel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 11/05/2025.
//

import Combine
import FirebaseAuth

class ProfileViewModel: ObservableObject {
    @Published var currentUser: User?
    
    @Published var email = ""
    @Published var name = ""
    
    private let userService = UserService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setUpSubscribers()
    }
    
    func setUpSubscribers() {
        userService.$currentUser.sink { [weak self] currentUser in
            self?.currentUser = currentUser
        }.store(in: &cancellables)
    }
}
