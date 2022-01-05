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
  let post: Post
  
  // MARK: - Init
  required init(router: PostRouter, post: Post) {
    self.router = router
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
  func didPressSavePostButton() {
    // TODO: Save post
  }
  
  func didPressOptionsButton() {
    self.router.goToPostOptionsPopup()
  }
  
  func didPressEditPostButton() {
    self.router.goToEditPost(post: post)
  }
}
