//
//  EditPostImagePicker.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Functions
extension EditPostViewController {
    func configureImagePickerController() {
        imagePickerController.delegate = self
        imagePickerController.modalPresentationStyle = .overFullScreen
    }
}

extension EditPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            viewModel.imagesModified = true
            viewModel.selectPhotoImageViews[viewModel.selectedIndexImageView].image = pickedImage
            viewModel.photosSelected[viewModel.selectedIndexImageView] = true
            checkAllContentsAreOk()
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
