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
  var numberOfTextFields = 0
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
    switch postType {
    case .lost:
      numberOfTextFields = 4
    case .found:
      numberOfTextFields = 3
    case .adopt:
      numberOfTextFields = 2
    }
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
  
  func sortNilImagesFromImageViewsToFinal() -> [UIImage?] {
    var imagesArray: [UIImage?] = []
    var sortedImagesArray: [UIImage?] = []
    
    selectPhotoImageViews.forEach { selectPhotoImageView in
      imagesArray.append(selectPhotoImageView.image)
    }
    
    sortedImagesArray = imagesArray
    
    for _ in 0...7 {
      sortedImagesArray.enumerated().forEach { image in
        if image.element == nil {
          let nextImageCopy = sortedImagesArray[image.offset + 1]
          sortedImagesArray[image.offset + 1] = image.element
          sortedImagesArray[image.offset] = nextImageCopy
          return
        }
      }
    }
    
    return sortedImagesArray
  }
  
  func didPressSelectPhotoButton() {
    guard let selectPhotoImageView = selectPhotoImageViews[selectedIndexImageView].image else { return }
    self.router.goToSelectPhotoPopup(showRemoveOption: !selectPhotoImageView.isEqualTo(image: UIImage(named: "SelectPhotoPlaceholder")))
  }
  
  func didPressAnimalTypeButton() {
    self.router.goToAnimalTypes(comesFrom: .newPost)
  }
  
  func didPressLocationButton() {
    self.router.goToWhereCanWeFindYou()
  }
  
  func didPressPublishPostButton(newPost: Post?) {
    // TODO: - Publish post
    if let _ = newPost {
      showSuccessPopup(title: "The post has been published successfully", action: self.router.goBackToTabBar())
    } else {
      showErrorPopup(title: "The post couldn't be created successfully", action: nil)
    }
  }
}
