//
//  TabBarViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 29/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation
import UIKit

final class TabBarViewModel {
  
  // MARK: - Properties
  private let router: TabBarRouter
  
  // MARK: - Init
  required init(router: TabBarRouter) {
    self.router = router
  }
  
}

// MARK: - Life cycle
extension TabBarViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    
  }
}

// MARK: - Functions
extension TabBarViewModel {
  func didPressExploreTabBarItem() -> UIViewController {
    return router.goToExplore()
  }
  
  func didPressNewPostTabBarItem() {
    self.router.goToNewPost()
  }
  
  func didPressProfileTabBarItem() -> UIViewController {
    return router.goToProfile()
  }
}
