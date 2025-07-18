//
//  PersonalDetailsCollectionViewCellViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 10/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

class PersonalDetailsCollectionViewCellViewModel: ViewModel {
    // MARK: - Properties
    var isAnimalShelter = false {
        didSet {
            numberOfTextFields = isAnimalShelter ? 2 : 4
            editedTextFields.removeAll()
        }
    }
    var numberOfTextFields = 4
    var editedTextFields = [CustomTextField]()
    var location: Location?
    
    // MARK: - Init
    init() {}
}

// MARK: - Functions
extension PersonalDetailsCollectionViewCellViewModel {
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
