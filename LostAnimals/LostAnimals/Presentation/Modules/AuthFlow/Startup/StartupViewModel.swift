//
//  StartupViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/11/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

final class StartupViewModel {
    // MARK: - Properties
    private let router: StartupRouter
    
    // MARK: - Init
    required init(router: StartupRouter) {
        self.router = router
    }
}

// MARK: - Life cycle
extension StartupViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension StartupViewModel {
    func didPressLoginButton() {
        self.router.goToLogin()
    }
    
    func didPressSignupButton() {
        self.router.gotoSignup()
    }
    
    func didPressContinueAsGuestButton() {
        if Cache.get(boolFor: .onboardingDone) {
            self.router.changeRootToTabBar()
        } else {
            self.router.goToOnboarding()
        }
    }
}
