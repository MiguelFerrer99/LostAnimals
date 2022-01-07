//
//  EditPostViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 4/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit

final class EditPostViewModel {
  
  // MARK: - Properties
  private let router: EditPostRouter
  let numberOfTextFields = 5
  var editedTextFields = [CustomTextField]()
  var selectPhotoImageViews: [UIImageView] = []
  var newPostLocation: Location? = nil
  let post: Post
  
  // MARK: - Init
  required init(router: EditPostRouter, post: Post) {
    self.router = router
    self.post = post
  }
}

// MARK: - Life cycle
extension EditPostViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    // Called when view has appeared
  }
}

// MARK: - Functions
extension EditPostViewModel {
  func textFieldsHaveErrors() -> Bool {
    var haveErrors = false
    editedTextFields.forEach { editedTextField in
      if editedTextField.hasError && !haveErrors { haveErrors = true }
    }
    return haveErrors
  }
  
  func didPressSelectPhotoButton(indexImageView: Int) {
    self.router.goToSelectPhotoPopup(showRemoveOption: selectPhotoImageViews[indexImageView].image != UIImage(named: "SelectPhotoPlaceholder"), indexImageView: indexImageView)
  }
  
  func didPressAnimalTypeButton() {
    self.router.goToAnimalTypes(selectedAnimalType: post.animal.type)
  }
  
  func didPressLocationButton() {
    self.router.goToWhereCanWeFindYou()
  }
  
  func didPressDeletePostButton() {
    self.router.goBack2Times()
    NotificationCenter.default.post(name: .ShowSuccessPopupFromEditPost, object: nil)
  }
  
  func didPressSaveChangesButton() {
    showSuccessPopup(title: "The changes has been saved successfully") {
      self.router.goBack()
    }
  }
}
