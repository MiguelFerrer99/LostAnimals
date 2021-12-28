//
//  Protocols.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 9/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation

protocol SignUpStepsDelegate: AnyObject {
  func moveToNextSignUpStep()
  func moveToPreviousSignUpStep()
  func goToWhereDoYouLiveCountries(comesFrom: WhereDoYouLiveComesFrom)
  func goToWhereCanWeFindYou()
  func updateSignUpUserInteraction(isUserInteractionEnabled: Bool)
  func sendSignUpStep1Data(isAnimalShelter: Bool, firstname: String?, lastname: String?, animalShelterName: String?, birthdate: Date?, address: String)
  func sendSignUpStep2Data(mail: String, password: String)
  func sendSignUpStep3Data(phonePrefix: String, phone: String, instagram: String?, twitter: String?)
}
