//
//  SignUpViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation

enum SignUpStep: Int {
    case personalDetails
    case accountDetails
    case socialMediaDetails
}

enum SignUpStepLabel: String {
    case personalDetails = "Personal details"
    case accountDetails = "Account details"
    case socialMediaDetails = "Social media details"
}

enum WhereDoYouLiveComesFrom: String {
    case signUpPersonalDetails
    case signUpSocialMediaDetails
    case editPersonalDetails
    case editSocialMediaDetails
}

final class SignUpViewModel {
    
    // MARK: - Properties
    private let router: SignUpRouter
    let numberOfSteps: Int = 3
    var currentStep: SignUpStep = .personalDetails
    var currentStepLabel: SignUpStepLabel = .personalDetails
    
    // MARK: - Init
    required init(router: SignUpRouter) {
        self.router = router
    }
    
}

// MARK: - Life cycle
extension SignUpViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        
    }
}

// MARK: - Functions
extension SignUpViewModel {
    func didPressGoToWhereDoYouLiveCountries(comesFrom: WhereDoYouLiveComesFrom) {
        self.router.goToWhereDoYouLiveCountries(comesFrom: comesFrom)
    }
    
    func didPressGoToWhereCanWeFindYou() {
        self.router.goToWhereCanWeFindYou()
    }
    
    func didPressGoToTermsAndConditions() {
        self.router.goToTermsAndConditions()
    }
    
    func didPressGetStartedButton() {
        User.shared = HardcodedData.exampleUser1
        Cache.set(.logged, true)
        let onboardingDone = Cache.get(boolFor: .onboardingDone)
        if onboardingDone {
            self.router.changeRootToTabBar()
        } else {
            self.router.goToOnboarding()
        }
    }
}
