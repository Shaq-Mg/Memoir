//
//  EditProfileViewModel.swift
//  Memoir
//
//  Created by Shaquille McGregor on 11/05/2025.
//

import SwiftUI
import FirebaseAuth
import PhotosUI

@MainActor
class EditProfileViewModel: ObservableObject {
    @Published var profileImage: Image?
    @Published var selectedItem: PhotosPickerItem? {
        didSet { Task { await loadImage() } }
    }
    @Published var uiImage: UIImage?
    
    private let userService = UserService.shared
    
    func updateUserData() async throws {
        try await uploadProfileImage()
    }
    
    private func loadImage() async {
        guard let item = selectedItem else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    private func uploadProfileImage() async throws {
        guard let image = self.uiImage else { return }
        guard let imageUrl = try? await ImageUploader.uploadImage(image) else { return }
        try await userService.updateUserProfileImage(withImageUrl: imageUrl)
    }
}
