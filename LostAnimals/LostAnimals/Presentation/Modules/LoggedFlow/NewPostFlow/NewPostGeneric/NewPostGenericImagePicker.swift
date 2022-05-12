//
//  NewPostGenericImagePicker.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 17/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Functions
extension NewPostGenericViewController {
    func configureImagePickerController() {
        imagePickerController.delegate = self
        imagePickerController.modalPresentationStyle = .overFullScreen
        imagePickerController.allowsEditing = true
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension NewPostGenericViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            viewModel.selectPhotoImageViews[viewModel.selectedIndexImageView].image = pickedImage
            checkAllContentsAreOk()
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
