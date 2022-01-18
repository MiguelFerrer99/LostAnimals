//
//  NewPostViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 29/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation

final class NewPostViewModel {
  
  // MARK: - Properties
  private let router: NewPostRouter
  
  // MARK: - Init
  required init(router: NewPostRouter) {
    self.router = router
  }
}

// MARK: - Life cycle
extension NewPostViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    
  }
}

// MARK: - Functions
extension NewPostViewModel {
  func didPressDismissButton() {
    self.router.dismissNewPost()
  }
  
  func didPressLostButton() {
    self.router.goToNewPostGeneric(postType: .lost)
  }
  
  func didPressFoundButton() {
    self.router.goToNewPostGeneric(postType: .found)
  }
  
  func didPressAdoptButton() {
    self.router.goToNewPostGeneric(postType: .adopt)
  }
}
