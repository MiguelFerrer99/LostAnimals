//
//  NewPostGenericImagePicker.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 17/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit

extension NewPostGenericViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  // MARK: - Functions
  func configureImagePickerController() {
    imagePickerController.delegate = self
    imagePickerController.modalPresentationStyle = .overFullScreen
    imagePickerController.allowsEditing = true
  }
  
  // MARK: - UIImagePickerControllerDelegate
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      viewModel.selectPhotoImageViews[viewModel.selectedIndexImageView].image = pickedImage
      picker.dismiss(animated: true, completion: nil)
    }
  }
}
