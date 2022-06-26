//
//  EditSocialMediasViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

// MARK: - Enums
enum EditSocialMediasFields {
    case phonePrefix
    case phoneNumber
    case instagram
    case twitter
}

final class EditSocialMediasViewModel {
    // MARK: - Properties
    private let router: EditSocialMediasRouter
    let me: User
    var numberOfTextFields = 1
    var editedTextFields = [CustomTextField]()
    var haveWhatsAppSelected = false
    var willHaveWhatsAppSelected = false
    var currentSocialMediasDetails: [EditSocialMediasFields: String] = [:]
    var newSocialMediasDetails: [EditSocialMediasFields: String] = [:]
    
    // MARK: - Services
    let userService = UserService()
    
    // MARK: - Init
    required init(router: EditSocialMediasRouter, me: User) {
        self.router = router
        self.me = me
        self.haveWhatsAppSelected = me.socialMedias[.whatsapp] != nil
        self.willHaveWhatsAppSelected = haveWhatsAppSelected
        self.currentSocialMediasDetails[.phonePrefix] = me.socialMedias[.phonePrefix]
        self.currentSocialMediasDetails[.phoneNumber] = me.socialMedias[.phoneNumber]
        self.currentSocialMediasDetails[.instagram] = me.socialMedias[.instagram]
        self.currentSocialMediasDetails[.twitter] = me.socialMedias[.twitter]
        self.newSocialMediasDetails = currentSocialMediasDetails
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
    
    func goBack() {
        showConfirmationPopup(title: .NewPostGeneric.AreYouSureExit()) {
            self.router.goBack()
        }
    }
    
    func didPressPhonePrefixButton() {
        self.router.goToWhereDoYouLiveCountries()
    }
    
    func didPressSaveChangesButton(completion: @escaping (() -> Void)) {
        let newWhatsAppValue = willHaveWhatsAppSelected ? ((newSocialMediasDetails[.phonePrefix] ?? "") + (newSocialMediasDetails[.phoneNumber] ?? "")) : nil
        userService.editUserSocialMediasDetails(phonePrefix: newSocialMediasDetails[.phonePrefix],
                                                phoneNumber: newSocialMediasDetails[.phoneNumber],
                                                whatsapp: newWhatsAppValue,
                                                instagram: newSocialMediasDetails[.instagram],
                                                twitter: newSocialMediasDetails[.twitter]) { result in
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
