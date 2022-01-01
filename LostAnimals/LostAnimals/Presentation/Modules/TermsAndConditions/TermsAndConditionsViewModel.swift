//
//  TermsAndConditionsViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation

final class TermsAndConditionsViewModel {
  
  // MARK: - Properties
  private let router: TermsAndConditionsRouter
  
  // MARK: - Init
  required init(router: TermsAndConditionsRouter) {
    self.router = router
  }
}

// MARK: - Life cycle
extension TermsAndConditionsViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    
  }
}

// MARK: - Functions
extension TermsAndConditionsViewModel {
}
