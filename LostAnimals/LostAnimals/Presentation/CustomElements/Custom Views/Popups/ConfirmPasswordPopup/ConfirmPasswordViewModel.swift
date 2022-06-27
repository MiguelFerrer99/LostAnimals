//
//  ConfirmPasswordViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 27/6/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

final class ConfirmPasswordViewModel {
    // MARK: - Properties
    private let router: ConfirmPasswordRouter
    private let completion: () -> ()
    let numberOfTextFields = 1
    var editedTextFields = [CustomTextField]()
    
    // MARK: - Services
    let authenticationService = AuthenticationService()
    let userService = UserService()
    
    // MARK: - Init
    required init(router: ConfirmPasswordRouter, completion: @escaping () -> ()) {
        self.router = router
        self.completion = completion
    }
}

// MARK: - Life cycle
extension ConfirmPasswordViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension ConfirmPasswordViewModel {
    func textFieldsHaveErrors() -> Bool {
        var haveErrors = false
        editedTextFields.forEach { editedTextField in
            if editedTextField.hasError && !haveErrors { haveErrors = true }
        }
        return haveErrors
    }
    
    func didPressDismissButton() {
        self.router.dismiss()
    }
    
    func didPressDeleteAccount(password: String, finished: @escaping (() -> Void)) {
        guard let me = User.shared else { return }
        self.authenticationService.logIn(email: me.email, password: password) { userResult in
            switch userResult {
            case .success:
                self.userService.deleteAccount { genericResult in
                    switch genericResult {
                    case .success:
                        finished()
                        self.router.dismiss {
                            self.completion()
                        }
                    case .error(let error):
                        finished()
                        self.router.dismiss {
                            self.completion()
                            showErrorPopup(title: error)
                        }
                    }
                }
            case .error(let error):
                finished()
                self.router.dismiss {
                    self.completion()
                    showErrorPopup(title: error)
                }
            }
        }
    }
}
