//
//  ChangePasswordViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 5/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

final class ChangePasswordViewModel {
    // MARK: - Properties
    private let router: ChangePasswordRouter
    var numberOfTextFields = 2
    var editedTextFields = [CustomTextField]()
    
    // MARK: - Init
    required init(router: ChangePasswordRouter) {
        self.router = router
    }
}

// MARK: - Life cycle
extension ChangePasswordViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension ChangePasswordViewModel {
    func textFieldsHaveErrors() -> Bool {
        var haveErrors = false
        editedTextFields.forEach { editedTextField in
            if editedTextField.hasError && !haveErrors {
                haveErrors = true
            }
        }
        return haveErrors
    }
    
    func didPressedSaveChangesButton() {
        self.router.goBack()
    }
}
