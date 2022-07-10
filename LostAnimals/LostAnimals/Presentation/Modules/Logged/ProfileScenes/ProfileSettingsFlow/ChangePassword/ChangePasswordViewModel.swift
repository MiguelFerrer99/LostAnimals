//
//  ChangePasswordViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 5/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

final class ChangePasswordViewModel {
    // MARK: - Properties
    private let router: ChangePasswordRouter
    let me: User
    var numberOfTextFields = 2
    var editedTextFields = [CustomTextField]()
    
    // MARK: - Services
    let userService = UserService()
    
    // MARK: - Init
    required init(router: ChangePasswordRouter, me: User) {
        self.router = router
        self.me = me
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
    
    func goBack() {
        showConfirmationPopup(title: .NewPostGeneric.AreYouSureExit()) {
            self.router.goBack()
        }
    }
    
    func didPressedSaveChangesButton(newPassword: String, completion: @escaping (() -> Void)) {
        userService.changePassword(newPassword: newPassword) { result in
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
