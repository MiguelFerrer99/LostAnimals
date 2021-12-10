//
//  WhereDoYouLiveViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 10/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation

final class WhereDoYouLiveViewModel {
  
  // MARK: - Properties
  private let router: WhereDoYouLiveRouter
  
  // MARK: - Init
  required init(router: WhereDoYouLiveRouter) {
    self.router = router
  }
  
}

// MARK: - Life cycle
extension WhereDoYouLiveViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    
  }
}

// MARK: - Functions
extension WhereDoYouLiveViewModel {
}
