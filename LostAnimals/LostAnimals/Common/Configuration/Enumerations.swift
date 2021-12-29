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

public enum MoveDirection {
  case back
  case next
}

public enum WhereDoYouLiveComesFrom {
  case personalDetails
  case socialMediaDetails
}

public enum OnboardingStep: Int {
  case share = 0
  case find = 1
  case contact = 2
}
