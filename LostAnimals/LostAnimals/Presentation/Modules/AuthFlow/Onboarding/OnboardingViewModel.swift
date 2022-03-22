//
//  OnboardingViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

// MARK: - Enums
enum OnboardingStep: Int {
    case share
    case find
    case contact
}

final class OnboardingViewModel {
    // MARK: - Properties
    private let router: OnboardingRouter
    var currentOnboardingStep: OnboardingStep = .share
    
    // MARK: - Init
    required init(router: OnboardingRouter) {
        self.router = router
    }
}

// MARK: - Life cycle
extension OnboardingViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension OnboardingViewModel {
    func didPressFinishOnboarding() {
        Cache.set(.onboardingDone, true)
        self.router.changeRootToTabBar()
    }
}
