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
  func didPressPostImage(indexPostImage: Int) {
    self.router.goToPostImages(postImages: post.animal.images, indexPostImages: indexPostImage)
  }
  
  func didPressLocation() {
    if let coordinates = post.location.coordinates {
      self.router.goToLocation(coordinates: coordinates, animal: post.animal)
    }
  }
  
  func didPressAuthor() {
    self.router.goToAuthorProfile()
  }
  
  func didPressContactWithAuthor() {
    self.router.showContactWithPopup(authorSocialMedias: post.author.socialMedias)
  }
  
  func didPressSavePostButton(allowed: ((Bool) -> ())) {
    let logged = Cache.get(boolFor: .logged)
    if logged {
      // TODO: - Save post
      allowed(true)
    } else {
      showGuestPopup()
      allowed(false)
    }
  }
  
  func didPressOptionsButton() {
    self.router.goToPostOptionsPopup(comesFrom: comesFrom, post: post)
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
    showErrorPopup(title: "Error reporting post. Please, try again later", action: nil)
  }
}
