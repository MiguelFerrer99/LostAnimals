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
  let indexImageView: Int
  
  // MARK: - Init
  required init(router: SelectPhotoPopupRouter, showRemoveOption: Bool, indexImageView: Int) {
    self.router = router
    self.showRemoveOption = showRemoveOption
    self.indexImageView = indexImageView
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
    self.router.dismissSelectPhotoPopupAndRemovePhoto(indexImageView: indexImageView)
  }
  
  func didPressChooseFromLibraryButton() {
    self.router.dismissSelectPhotoPopupAndChooseFromLibrary(indexImageView: indexImageView)
  }
  
  func didPressTakeAPhotoButton() {
    self.router.dismissSelectPhotoPopupAndTakeAPhoto(indexImageView: indexImageView)
  }
}
