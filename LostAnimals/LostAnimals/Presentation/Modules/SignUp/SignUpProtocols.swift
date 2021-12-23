//
//  SignUpProtocols.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 9/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation

extension SignUpViewController: SignUpStepsDelegate {
  // MARK: - SignUpStepsDelegate
  func moveToNextSignUpStep() {
    moveToNextStep()
  }
  
  func moveToPreviousSignUpStep() {
    moveToPreviousStep()
  }
  
  func goToWhereDoYouLiveCountries() {
    goToWhereDoYouLive()
  }
  
  func goToWhereCanWeFindYou() {
    goToWhereCanWeFindYouAddress()
  }
  
  func sendSignUpStep1Data(isAnimalShelter: Bool, firstname: String? = nil, lastname: String? = nil, animalShelterName: String? = nil, birthdate: Date? = nil, address: String) {
    print("""
          SIGNUP STEP1 DATA RECEIVED:
            isAnimalShelter: \(isAnimalShelter),
            firstname: \(firstname ?? "nil"),
            lastname: \(lastname ?? "nil"),
            animalShelterName: \(animalShelterName ?? "nil"),
            birthdate: \(birthdate?.toString(withFormat: DateFormat.dayMonthYearOther) ?? "nil"),
            address: \(address)
          """)
  }
  
  func sendSignUpStep2Data(mail: String, password: String) {
    print("""
          SIGNUP STEP2 DATA RECEIVED:
            mail: \(mail),
            password: \(password)
          """)
  }
  
  func sendSignUpStep3Data() {
    print("""
          SIGNUP STEP3 DATA RECEIVED:
          """)
  }
}
