//
//  StartupViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/11/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation

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
    func viewReady() {}
    
    func viewDidAppear() {}
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
        let onboardingDone = Cache.get(boolFor: .onboardingDone)
        if onboardingDone {
            self.router.changeRootToTabBar()
        } else {
            self.router.goToOnboarding()
        }
    }
}
