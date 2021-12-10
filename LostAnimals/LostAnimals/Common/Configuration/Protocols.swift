//
//  Protocols.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 9/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation

public protocol SignUpStepsDelegate: AnyObject {
  func moveToNextSignUpStep()
  func moveToPreviousSignUpStep()
}
