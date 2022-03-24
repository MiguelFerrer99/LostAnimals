//
//  LoginViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 22/11/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

final class LoginViewModel {
    // MARK: - Properties
    private let router: LoginRouter
    let numberOfTextFields = 2
    var editedTextFields = [CustomTextField]()
        
    // MARK: - Services
    let authenticationService = AuthenticationService()
    
    // MARK: - Init
    required init(router: LoginRouter) {
        self.router = router
    }
}

// MARK: - Life cycle
extension LoginViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension LoginViewModel {
    func textFieldsHaveErrors() -> Bool {
        var haveErrors = false
        editedTextFields.forEach { editedTextField in
            if editedTextField.hasError && !haveErrors { haveErrors = true }
        }
        return haveErrors
    }
    
    func didPressForgotPasswordButton() {
        self.router.goToForgotPassword()
    }
    
    func didPressLoginButton(email: String, password: String, completion: @escaping (() -> Void)) {
        authenticationService.logIn(email: email, password: password) { result in
            switch result {
            case .success(let loggedUser):
                if loggedUser.banned {
                    showBannedPopup(comesFrom: .login)
                } else {
                    User.shared = loggedUser
                    Cache.set(.logged, true)
                    if Cache.get(boolFor: .onboardingDone) {
                        self.router.changeRootToTabBar()
                    } else {
                        self.router.goToOnboarding()
                    }
                }
                completion()
            case .error(let error):
                showErrorPopup(title: error)
                completion()
            }
        }
    }
}
