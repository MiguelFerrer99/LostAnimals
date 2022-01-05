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
  
  func goToWhereDoYouLiveCountries(comesFrom: WhereDoYouLiveComesFrom) {
    goToWhereDoYouLive(comesFrom: comesFrom)
  }
  
  func goToWhereCanWeFindYou() {
    goToWhereCanWeFindYouAddress()
  }
  
  func goToTermsAndConditions() {
    goToTermsAndConditionsVC()
  }
  
  func updateSignUpUserInteraction(isUserInteractionEnabled: Bool) {
    navigationController?.navigationBar.isUserInteractionEnabled = isUserInteractionEnabled
    navigationController?.interactivePopGestureRecognizer?.isEnabled = isUserInteractionEnabled
  }
  
  func sendSignUpStep1Data(isAnimalShelter: Bool, firstname: String? = nil, lastname: String? = nil, animalShelterName: String? = nil, birthdate: Date? = nil, address: String, location: Location? = nil) {
    print("""
          SIGNUP STEP1 DATA RECEIVED:
            isAnimalShelter: \(isAnimalShelter),
            firstname: \(firstname == nil || (firstname?.isEmpty ?? true) ? "-" : firstname ?? "-"),
            lastname: \(lastname == nil || (lastname?.isEmpty ?? true) ? "-" : lastname ?? "-"),
            animalShelterName: \(animalShelterName == nil || (animalShelterName?.isEmpty ?? true) ? "-" : animalShelterName ?? "-"),
            birthdate: \(birthdate?.toString(withFormat: DateFormat.dayMonthYearOther) ?? "-"),
            address: \(address),
            location:
              lat  = \(location?.lat ?? 0)
              long = \(location?.long ?? 0)
          """)
  }
  
  func sendSignUpStep2Data(mail: String, password: String) {
    print("""
          SIGNUP STEP2 DATA RECEIVED:
            mail: \(mail),
            password: \(password)
          """)
  }
  
  func sendSignUpStep3Data(phonePrefix: String, phone: String, instagram: String? = nil, twitter: String? = nil) {
    print("""
          SIGNUP STEP3 DATA RECEIVED:
            phonePrefix: \(phonePrefix),
            phone: \(phone),
            instagram: \(instagram ?? "-"),
            twitter: \(twitter ?? "-")
          """)
  }
}
