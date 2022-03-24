//
//  EditSocialMediasViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

final class EditSocialMediasViewModel {
    // MARK: - Properties
    private let router: EditSocialMediasRouter
    let me: User
    var numberOfTextFields = 1
    var editedTextFields = [CustomTextField]()
    var haveWhatsAppSelected = false
    
    // MARK: - Init
    required init(router: EditSocialMediasRouter, me: User) {
        self.router = router
        self.me = me
        self.haveWhatsAppSelected = me.socialMedias[.whatsapp] != nil
    }
}

// MARK: - Life cycle
extension EditSocialMediasViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension EditSocialMediasViewModel {
    func textFieldsHaveErrors() -> Bool {
        var haveErrors = false
        editedTextFields.forEach { editedTextField in
            if editedTextField.hasError && !haveErrors {
                haveErrors = true
            }
        }
        return haveErrors
    }
    
    func didPressPhonePrefixButton() {
        self.router.goToWhereDoYouLiveCountries()
    }
    
    func didPressSaveChangesButton() {
        showSuccessPopup(title: "The changes has been saved successfully") {
            self.router.goBack()
        }
    }
}
