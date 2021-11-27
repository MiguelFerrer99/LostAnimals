//
//  CustomTextField-Models.swift
//  Template
//
//  Created by Toni García Alhambra on 11/03/2020.
//  Copyright © 2020 Rudo. All rights reserved.
//

import UIKit

class TextFieldError {
  let localizedDescription: String
  let checkCondition: ((String) -> Bool)

  init(localizedDescription: String, checkCondition: @escaping ((String) -> Bool)) {
    self.localizedDescription = localizedDescription
    self.checkCondition       = checkCondition
  }
}

class TextFieldErrorMinimumCharacters: TextFieldError {
  let minCharacters: Int

  init(_ minCharacters: Int) {
    self.minCharacters = minCharacters

    super.init(localizedDescription: "Minimum \(minCharacters) characters") { (value) -> Bool in
      return value.count < minCharacters
    }
  }
}

class TextFieldErrorEmailFormat: TextFieldError {
  init() {
    super.init(localizedDescription: "Invalid email format") { (value) -> Bool in
      return !value.isValidEmail()
    }
  }
}

class TextFieldErrorEmptyValue: TextFieldError {
  init() {
    super.init(localizedDescription: "Empty field") { (value) -> Bool in
      return value.isEmpty
    }
  }
}

class TextFieldErrorPasswordFormat: TextFieldError {
  init() {
    super.init(localizedDescription: "Invalid password format") { (value) -> Bool in
      return !value.isValidPassword()
    }
  }
}
