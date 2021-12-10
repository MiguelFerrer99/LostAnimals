//
//  Enumerations.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 9/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation

public enum SignUpStep: Int {
  case personalDetails = 0
  case accountDetails = 1
  case socialMediaDetails = 2
}

public enum SignUpStepLabel: String {
  case personalDetails = "Personal details"
  case accountDetails = "Account details"
  case socialMediaDetails = "Social media details"
}

public enum SignUpMoveDirection {
  case back
  case next
}
