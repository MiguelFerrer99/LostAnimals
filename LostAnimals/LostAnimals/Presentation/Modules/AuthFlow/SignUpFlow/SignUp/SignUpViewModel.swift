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

typealias PersonalDetails = (animalShelter: Bool, firstname: String, lastname: String, birthdate: String?, location: Location)
typealias AccountDetails = (email: String, password: String)
typealias UserDetails = (personalDetails: PersonalDetails, accountDetails: AccountDetails, socialMedias: [SocialMediaType: String])

final class SignUpViewModel {
    
    // MARK: - Properties
    private let router: SignUpRouter
    let numberOfSteps: Int = 3
    var currentStep: SignUpStep = .personalDetails
    var currentStepLabel: SignUpStepLabel = .personalDetails
    
    // MARK: - AuthenticationService properties
    var user = Constants.emptyUser
    var userPassword = ""
    
    // MARK: - Services
    let authenticationService = AuthenticationService()
    
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
        // Called when view has appeared
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
    
    func didPressGetStartedButton(completion: @escaping (() -> Void)) {
        authenticationService.signUp(user: user, userPassword: userPassword) { result in
            switch result {
            case .success(let user):
                User.shared = user
                Cache.set(.logged, true)
                if Cache.get(boolFor: .onboardingDone) {
                    self.router.changeRootToTabBar()
                } else {
                    self.router.goToOnboarding()
                }
                completion()
            case .error(let error):
                showErrorPopup(title: error, action: nil)
                completion()
            }
        }
    }
}
