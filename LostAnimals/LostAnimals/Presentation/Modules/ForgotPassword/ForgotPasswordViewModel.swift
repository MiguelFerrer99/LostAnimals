//
//  ForgotPasswordViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation

final class ForgotPasswordViewModel {
  
  // MARK: - Properties
  private let router: ForgotPasswordRouter
  var editedTextFields = [CustomTextField]()
  
  // MARK: - Init
  required init(router: ForgotPasswordRouter) {
    self.router = router
  }
  
}

// MARK: - Life cycle
extension ForgotPasswordViewModel {
  func viewReady() {
    // Called when view is loaded and ready
  }
  
  func viewDidAppear() {
    
  }
}

// MARK: - Functions
extension ForgotPasswordViewModel {
  func textFieldsHaveErrors() -> Bool {
    var haveErrors = false
    editedTextFields.forEach { editedTextField in
      if editedTextField.hasError && !haveErrors { haveErrors = true }
    }
    return haveErrors
  }
  
  func didPressForgotPasswordButton() {
    // TODO: Call API
  }
}
