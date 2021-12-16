//
//  SignUpProtocols.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 9/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation

extension SignUpViewController: SignUpStepsDelegate {
  func moveToNextSignUpStep() {
    moveToNextStep()
  }
  
  func moveToPreviousSignUpStep() {
    moveToPreviousStep()
  }
  
  func signUpGoToWhereDoYouLiveCountries() {
    goToWhereDoYouLiveCountries()
  }
}
