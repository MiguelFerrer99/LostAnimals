//
//  SelectPhotoPopupViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

final class SelectPhotoPopupViewModel {
  
  // MARK: - Properties
  private let router: SelectPhotoPopupRouter
  let showRemoveOption: Bool
  
  // MARK: - Init
  required init(router: SelectPhotoPopupRouter, showRemoveOption: Bool) {
    self.router = router
    self.showRemoveOption = showRemoveOption
  }
}

// MARK: - Life cycle
extension SelectPhotoPopupViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    // Called when view has appeared
  }
}

// MARK: - Functions
extension SelectPhotoPopupViewModel {
  func didPressDismissButton() {
    self.router.dismissSelectPhotoPopup()
  }
  
  func didPressRemovePhotoButton() {
    self.router.dismissSelectPhotoPopupAndRemovePhoto()
  }
  
  func didPressChooseFromLibraryButton() {
    self.router.dismissSelectPhotoPopupAndChooseFromLibrary()
  }
  
  func didPressTakeAPhotoButton() {
    self.router.dismissSelectPhotoPopupAndTakeAPhoto()
  }
}
