//
//  SuccessPopupViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

final class SuccessPopupViewModel {
  
  // MARK: - Properties
  private let router: SuccessPopupRouter
  let successTitle: String
  
  // MARK: - Init
  required init(router: SuccessPopupRouter, successTitle: String) {
    self.router = router
    self.successTitle = successTitle
  }
}

// MARK: - Life cycle
extension SuccessPopupViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    // Called when view has appeared
  }
}

// MARK: - Functions
extension SuccessPopupViewModel {
  func didPressDismissButton() {
    self.router.dismissSuccessPopup()
  }
  
  func didPressOkButton() {
    self.router.dismissSuccessPopup()
  }
}
