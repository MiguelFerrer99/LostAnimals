//
//  ProfileSettingsImagePicker.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Functions
extension ProfileSettingsViewController {
    func configureImagePickerController() {
        imagePickerController.delegate = self
        imagePickerController.modalPresentationStyle = .overFullScreen
        imagePickerController.allowsEditing = true
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension ProfileSettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            switch viewModel.selectedImageView {
            case .user:   profileImageView.image = pickedImage
            case .header: headerImageView.image = pickedImage
            }
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
