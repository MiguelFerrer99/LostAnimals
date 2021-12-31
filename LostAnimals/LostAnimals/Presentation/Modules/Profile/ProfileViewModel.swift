//
//  ProfileViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 30/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation

final class ProfileViewModel {
  
  // MARK: - Properties
  private let router: ProfileRouter
  
  // MARK: - Init
  required init(router: ProfileRouter) {
    self.router = router
  }
}

// MARK: - Life cycle
extension ProfileViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    
  }
}

// MARK: - Functions
extension ProfileViewModel {
}
