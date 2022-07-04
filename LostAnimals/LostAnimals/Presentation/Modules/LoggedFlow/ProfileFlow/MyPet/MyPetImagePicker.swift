//
//  MyPetImagePicker.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 4/7/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Functions
extension MyPetViewController {
    func configureImagePickerController() {
        imagePickerController.delegate = self
        imagePickerController.modalPresentationStyle = .overFullScreen
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension MyPetViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            viewModel.imagesModified = true
            viewModel.selectPhotoImageViews[viewModel.selectedIndexImageView].image = pickedImage
            checkAllContentsAreOk()
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
