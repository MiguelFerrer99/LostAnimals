//
//  SignUpViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation

final class SignUpViewModel {
  
  // MARK: - Properties
  private let router: SignUpRouter
  
  // MARK: - Init
  required init(router: SignUpRouter) {
    self.router = router
  }
  
}

// MARK: - Life cycle
extension SignUpViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    
  }
}

// MARK: - Functions
extension SignUpViewModel {
}
