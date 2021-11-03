//
//  OnboardingViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/11/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation

final class OnboardingViewModel {
  
  // MARK: - Properties
  private let router: OnboardingRouter
  
  // MARK: - Init
  required init(router: OnboardingRouter) {
    self.router = router
  }
}

// MARK: - Life cycle
extension OnboardingViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    
  }
}

// MARK: - Functions
extension OnboardingViewModel {}
