//
//  PostOptionsPopupViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

final class PostOptionsPopupViewModel {
  
  // MARK: - Properties
  private let router: PostOptionsPopupRouter
  
  // MARK: - Init
  required init(router: PostOptionsPopupRouter) {
    self.router = router
  }
}

// MARK: - Life cycle
extension PostOptionsPopupViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    // Called when view has appeared
  }
}

// MARK: - Functions
extension PostOptionsPopupViewModel {
  func didPressDismissButton() {
    self.router.dismissPostOptionsPopup()
  }
  
  func didPressEditPostButton() {
    self.router.goBack()
  }
  
  func didPressReportPostButton() {
    // TODO: Report post
  }
}
