//
//  LoginViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 22/11/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation

final class LoginViewModel {
    
    // MARK: - Properties
    private let router: LoginRouter
    let numberOfTextFields = 2
    var editedTextFields = [CustomTextField]()
    
    // MARK: - Dynamic properties
    
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
    
    func didPressLoginButton() {
        User.shared = HardcodedData.exampleUser1
        
        if User.shared?.isBanned ?? false { showBannedPopup(comesFrom: .login) }
        else {
            Cache.set(.logged, true)
            let onboardingDone = Cache.get(boolFor: .onboardingDone)
            if onboardingDone {
                self.router.changeRootToTabBar()
            } else {
                self.router.goToOnboarding()
            }
        }
    }
}
