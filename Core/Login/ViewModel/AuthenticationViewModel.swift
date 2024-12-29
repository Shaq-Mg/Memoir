//
//  AuthenticationViewModel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 27/12/2024.
//

import SwiftUI
import PhotosUI
import FirebaseAuth
import FirebaseFirestore

final class AuthenticationViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    @Published var selectedItem: PhotosPickerItem? = nil
    @Published var selectedImageData: Data? = nil
    @Published var fileURL: URL? = nil
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var profileImageUrl = ""
    @Published var errorMessage = ""
    
    let authService = AuthService()
    
    init() {
        DispatchQueue.main.async {
            self.userSession = Auth.auth().currentUser
        }
        
        Task {
            await fetchUser()
        }
    }
    
    func clearLoginInformation() {
        email = ""
        password = ""
        confirmPassword = ""
        profileImageUrl = ""
        errorMessage = ""
        selectedItem = nil
        selectedImageData = nil
        fileURL = nil
    }
    
    func createUser(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, name: name, email: email, imageUrl: profileImageUrl)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await authService.userDocument(userId: user.id).setData(encodedUser)
            self.persistImageToFileManager()
            await fetchUser()
        } catch {
            errorMessage = "Failed to created user with error \(error.localizedDescription)"
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            errorMessage = "Failed to login user with error \(error.localizedDescription)"
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await authService.userDocument(userId: uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut() // signs out user on backend
            self.userSession = nil // wipes out user session and takes us back to login screen
            self.currentUser = nil // wipes out current user data model
        } catch {
            errorMessage = "Failed to sign out user with error \(error.localizedDescription)"
        }
    }
    
    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else {
            return // handle error
        }
        try await user.delete()
    }
}

extension AuthenticationViewModel {
    
    func persistImageToFileManager() {
        if let data = selectedImageData {
            self.saveImageToFileManager(data: data)
        }
    }
    
    private func saveImageToFileManager(data: Data) {
        let fileManager = FileManager.default
        let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = UUID().uuidString + ".jpg"
        let filePath = directory.appendingPathComponent(fileName)
        
        do {
            try data.write(to: filePath)
            fileURL = filePath
            print("Image saved at \(filePath)")
            self.errorMessage = "Successfully stored image with url: \(filePath)"
        } catch {
            print("Error saving image: \(error.localizedDescription)")
            self.errorMessage = "Failed to push image to storage: \(error)"
        }
    }
}
