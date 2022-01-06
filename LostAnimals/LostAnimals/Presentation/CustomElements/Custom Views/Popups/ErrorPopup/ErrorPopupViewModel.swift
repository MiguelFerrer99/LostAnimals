//
//  ErrorPopupViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

final class ErrorPopupViewModel {
  
  // MARK: - Properties
  private let router: ErrorPopupRouter
  
  // MARK: - Init
  required init(router: ErrorPopupRouter) {
    self.router = router
  }
}

// MARK: - Life cycle
extension ErrorPopupViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    // Called when view has appeared
  }
}

// MARK: - Functions
extension ErrorPopupViewModel {
  func didPressDismissButton() {
    self.router.dismissErrorPopup()
  }
  
  func didPressOkButton() {
    self.router.dismissErrorPopup()
  }
}
