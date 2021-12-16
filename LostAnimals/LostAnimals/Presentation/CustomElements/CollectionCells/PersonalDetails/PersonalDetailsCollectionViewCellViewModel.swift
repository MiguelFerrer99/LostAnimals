//
//  PersonalDetailsCollectionViewCellViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 10/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

class PersonalDetailsCollectionViewCellViewModel: ViewModel {
  // MARK: - Properties
  var editedTextFields = [CustomTextField]()
  
  // MARK: - Init
  init() {}
  
  // MARK: - Functions
  func textFieldsHaveErrors() -> Bool {
    var haveErrors = false
    editedTextFields.forEach { editedTextField in
      if editedTextField.hasError && !haveErrors {
        haveErrors = true
      }
    }
    return haveErrors
  }
}
