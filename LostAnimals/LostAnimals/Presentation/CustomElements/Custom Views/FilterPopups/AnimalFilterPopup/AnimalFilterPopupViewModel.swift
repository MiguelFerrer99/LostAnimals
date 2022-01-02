//
//  AnimalFilterPopupViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 2/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

final class AnimalFilterPopupViewModel {
  
  // MARK: - Properties
  private let router: AnimalFilterPopupRouter
  
  // MARK: - Init
  required init(router: AnimalFilterPopupRouter) {
    self.router = router
  }
}

// MARK: - Life cycle
extension AnimalFilterPopupViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    
  }
}

// MARK: - Functions
extension AnimalFilterPopupViewModel {
  func didPressApplyFilterButton() {
    self.router.dismissAnimalFilterPopup()
  }
  
  func didPressDismissButton() {
    self.router.dismissAnimalFilterPopup()
  }
}
