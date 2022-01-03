//
//  ExploreViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 29/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class ExploreViewModel {
  
  // MARK: - Properties
  private let router: ExploreRouter
  
  // MARK: - Init
  required init(router: ExploreRouter) {
    self.router = router
  }
}

// MARK: - Life cycle
extension ExploreViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    
  }
}

// MARK: - Functions
extension ExploreViewModel {
  func didPressPostsFilterPopup(filterType: FilterType) {
    self.router.goToFilterPopup(filterType: filterType)
  }
  
  func didPressSavedPosts() {
    self.router.goToSavedPosts()
  }
}
