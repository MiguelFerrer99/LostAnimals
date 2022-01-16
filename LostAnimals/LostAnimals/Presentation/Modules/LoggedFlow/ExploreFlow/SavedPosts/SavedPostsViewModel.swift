//
//  SavedPostsViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

final class SavedPostsViewModel {
  
  // MARK: - Properties
  private let router: SavedPostsRouter
  
  // MARK: - Init
  required init(router: SavedPostsRouter) {
    self.router = router
  }
}

// MARK: - Life cycle
extension SavedPostsViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    // Called when view has appeared
    Filters.resetFilters()
    NotificationCenter.default.post(name: .UpdateFiltersUI, object: nil)
  }
}

// MARK: - Functions
extension SavedPostsViewModel {
  func didPressPostsFilterPopup(filterType: FilterType) {
    self.router.goToFilterPopup(filterType: filterType)
  }
  
  func didPressPost(post: Post) {
    self.router.goToPost(post: post)
  }
}
