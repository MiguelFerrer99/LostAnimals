//
//  NewPostGenericViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 17/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit

final class NewPostGenericViewModel {
  
  // MARK: - Properties
  private let router: NewPostGenericRouter
  var numberOfTextFields = 4
  let postType: PostType
  var editedTextFields = [CustomTextField]()
  var selectPhotoImageViews: [UIImageView] = []
  var selectedIndexImageView = 0
  var newPostLocation: Location? = nil
  var selectedAnimalType: AnimalType? = nil
  
  // MARK: - Init
  required init(router: NewPostGenericRouter, postType: PostType) {
    self.router = router
    self.postType = postType
    if postType == .lost { numberOfTextFields = 5 }
  }
}

// MARK: - Life cycle
extension NewPostGenericViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    // Called when view has appeared
  }
}

// MARK: - Functions
extension NewPostGenericViewModel {
  func textFieldsHaveErrors() -> Bool {
    var haveErrors = false
    editedTextFields.forEach { editedTextField in
      if editedTextField.hasError && !haveErrors { haveErrors = true }
    }
    return haveErrors
  }
  
  func didPressSelectPhotoButton() {
    self.router.goToSelectPhotoPopup(showRemoveOption: selectPhotoImageViews[selectedIndexImageView].image != UIImage(named: "SelectPhotoPlaceholder"))
  }
  
  func didPressAnimalTypeButton() {
    self.router.goToAnimalTypes(comesFrom: .newPost)
  }
  
  func didPressLocationButton() {
    self.router.goToWhereCanWeFindYou()
  }
  
  func didPressPublishPostButton() {
    showSuccessPopup(title: "The post has been published successfully") {
      self.router.goBack()
    }
  }
}
