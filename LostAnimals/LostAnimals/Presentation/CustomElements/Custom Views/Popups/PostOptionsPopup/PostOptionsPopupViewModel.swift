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
  let comesFrom: PostComesFrom
  let post: Post
  
  // MARK: - Init
  required init(router: PostOptionsPopupRouter, comesFrom: PostComesFrom, post: Post) {
    self.router = router
    self.comesFrom = comesFrom
    self.post = post
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
    self.router.dismissPostOptionsPopupAndGoToEditPost()
  }
  
  func didPressReportPostButton() {
    let logged = Cache.get(boolFor: .logged)
    if logged {
      self.router.dismissPostOptionsPopup()
      NotificationCenter.default.post(name: .ShowSuccessPopupFromPostOptionsPopup, object: nil)
    } else {
      self.router.dismissPostOptionsPopupAndShowGuestPopup()
    }
  }
  
  func didPressSharePostButton() {
    self.router.dismissPostOptionsAndShowActivityViewController()
  }
}
