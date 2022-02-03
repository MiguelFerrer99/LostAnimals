//
//  AccountDetailsCollectionViewCellViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 21/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

class AccountDetailsCollectionViewCellViewModel: ViewModel {
    // MARK: - Properties
    var numberOfTextFields = 3
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
