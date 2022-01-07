//
//  PostImagesViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

final class PostImagesViewModel {
  
  // MARK: - Properties
  private let router: PostImagesRouter
  
  // MARK: - Init
  required init(router: PostImagesRouter) {
    self.router = router
  }
}

// MARK: - Life cycle
extension PostImagesViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    // Called when view has appeared
  }
}

// MARK: - Functions
extension PostImagesViewModel {
}
