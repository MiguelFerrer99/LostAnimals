//
//  EditPersonalDetailsViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 5/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

// MARK: - Enums
enum EditPersonalDetailsField {
    case firstname
    case lastname
    case birthdate
}

final class EditPersonalDetailsViewModel {
    // MARK: - Properties
    private let router: EditPersonalDetailsRouter
    let me: User
    var numberOfTextFields = 0
    var editedTextFields = [CustomTextField]()
    var currentLocation: Location
    var newLocation: Location
    var currentPersonalDetailsValues: [EditPersonalDetailsField: String] = [:]
    var newPersonalDetailsValues: [EditPersonalDetailsField: String] = [:]
    
    // MARK: - Services
    let userService = UserService()
    
    // MARK: - Init
    required init(router: EditPersonalDetailsRouter, me: User) {
        self.router = router
        self.me = me
        if me.animalShelter {
            self.numberOfTextFields = 2
            self.currentPersonalDetailsValues[.firstname] = me.firstname
            self.currentLocation = me.location
        } else {
            self.numberOfTextFields = 4
            self.currentPersonalDetailsValues[.firstname] = me.firstname
            self.currentPersonalDetailsValues[.lastname] = me.lastname
            if let birthdate = me.birthdate { self.currentPersonalDetailsValues[.birthdate] = birthdate }
            self.currentLocation = me.location
        }
        self.newPersonalDetailsValues = currentPersonalDetailsValues
        self.newLocation = currentLocation
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
    
    func goBack() {
        showConfirmationPopup(title: .NewPostGeneric.AreYouSureExit()) {
            self.router.goBack()
        }
    }
    
    func didPressedWhereDoYouLiveButton() {
        self.router.goToWhereDoYouLive()
    }
    
    func didPressedWhereCanWeFindYouButton() {
        self.router.goToWhereCanWeFindYou()
    }
    
    func didPressedSaveChangesButton(completion: @escaping (() -> Void)) {
        if me.animalShelter {
            userService.editUserPersonalDetails(animalShelterName: newPersonalDetailsValues[.firstname],
                                                whereCanWeFindYou: newLocation) { result in
                switch result {
                case .success:
                    completion()
                    showSuccessPopup(title: .Commons.ChangesSaved()) {
                        self.router.goBack()
                    }
                case .error(let error):
                    completion()
                    showErrorPopup(title: error)
                }
            }
        } else {
            userService.editUserPersonalDetails(firstname: newPersonalDetailsValues[.firstname],
                                                lastname: newPersonalDetailsValues[.lastname],
                                                birthdate: newPersonalDetailsValues[.birthdate],
                                                whereDoYouLive: newLocation) { result in
                switch result {
                case .success:
                    completion()
                    showSuccessPopup(title: .Commons.ChangesSaved()) {
                        self.router.goBack()
                    }
                case .error(let error):
                    completion()
                    showErrorPopup(title: error)
                }
            }
        }
    }
}
