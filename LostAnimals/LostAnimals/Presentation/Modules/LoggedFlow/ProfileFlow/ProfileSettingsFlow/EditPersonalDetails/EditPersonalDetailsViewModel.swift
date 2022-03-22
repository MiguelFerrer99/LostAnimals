//
//  EditPersonalDetailsViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 5/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

final class EditPersonalDetailsViewModel {
    // MARK: - Properties
    private let router: EditPersonalDetailsRouter
    let me: User
    var numberOfTextFields = 0
    var editedTextFields = [CustomTextField]()
    var location: Location? = nil
    
    // MARK: - Init
    required init(router: EditPersonalDetailsRouter, me: User) {
        self.router = router
        self.me = me
        self.numberOfTextFields = me.animalShelter ? 2 : 4
    }
}

// MARK: - Life cycle
extension EditPersonalDetailsViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension EditPersonalDetailsViewModel {
    func textFieldsHaveErrors() -> Bool {
        var haveErrors = false
        editedTextFields.forEach { editedTextField in
            if editedTextField.hasError && !haveErrors {
                haveErrors = true
            }
        }
        return haveErrors
    }
    
    func didPressedWhereDoYouLiveButton() {
        self.router.goToWhereDoYouLive()
    }
    
    func didPressedWhereCanWeFindYouButton() {
        self.router.goToWhereCanWeFindYou()
    }
    
    func didPressedSaveChangesButton() {
        showSuccessPopup(title: "The changes has been saved successfully", action: self.router.goBack())
    }
}
