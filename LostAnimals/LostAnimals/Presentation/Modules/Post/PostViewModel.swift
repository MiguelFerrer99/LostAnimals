//
//  PostViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

final class PostViewModel {
  
  // MARK: - Properties
  private let router: PostRouter
  let comesFrom: PostComesFrom
  let post: Post
  
  // MARK: - Init
  required init(router: PostRouter, comesFrom: PostComesFrom, post: Post) {
    self.router = router
    self.comesFrom = comesFrom
    self.post = post
  }
}

// MARK: - Life cycle
extension PostViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    // Called when view has appeared
  }
}

// MARK: - Functions
extension PostViewModel {
  func didPressLocation() {
    if let location = post.location {
      self.router.goToLocation(location: location, animal: post.animal)
    }
  }
  
  func didPressAuthor() {
    self.router.goToAuthorProfile()
  }
  
  func didPressContactWithAuthor() {
    self.router.showContactWithPopup()
  }
  
  func didPressSavePostButton() {
    let logged = Cache.get(boolFor: .logged)
    if logged {
      // TODO: - Save post
    } else {
      showGuestPopup()
    }
  }
  
  func didPressOptionsButton() {
    self.router.goToPostOptionsPopup(comesFrom: comesFrom)
  }
  
  func didPressEditPostButton() {
    self.router.goToEditPost(post: post)
  }
  
  func showGuestPopupFromPostOptionsPopup() {
    showGuestPopup()
  }
  
  func showSuccessPopupFromPostOptionsPopup() {
    showSuccessPopup(title: "The post has been reported successfully", action: nil)
  }
  
  func showErrorPopupFromPostOptionsPopup() {
    showErrorPopup(action: nil)
  }
}
