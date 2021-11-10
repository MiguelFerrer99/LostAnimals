//
//  ScrollViewExampleViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 10/11/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation

final class ScrollViewExampleViewModel {
  
  // MARK: - Properties
  private let router: ScrollViewExampleRouter
  
  // MARK: - Init
  required init(router: ScrollViewExampleRouter) {
    self.router = router
  }
  
}

// MARK: - Life cycle
extension ScrollViewExampleViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    
  }
}

// MARK: - Functions
extension ScrollViewExampleViewModel {
}
