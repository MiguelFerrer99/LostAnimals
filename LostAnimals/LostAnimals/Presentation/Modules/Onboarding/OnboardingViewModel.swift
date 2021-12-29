//
//  OnboardingViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class OnboardingViewModel {
  
  // MARK: - Properties
  private let router: OnboardingRouter
  var currentOnboardingStep: OnboardingStep = .share
  let onboardingSummaries = [
    OnboardingCollectionViewCellSummary(title: "Share",
                                        description: "Have you lost your pet? We help you to find her by sharing information. Everyone stay tuned! 👀",
                                        image: UIImage(named: "OnboardingItem1") ?? UIImage()),
    OnboardingCollectionViewCellSummary(title: "Find",
                                        description: "Have you seen an abandoned pet? Share it so everyone knows where and when have you seen it 🔍",
                                        image: UIImage(named: "OnboardingItem2") ?? UIImage()),
    OnboardingCollectionViewCellSummary(title: "Contact",
                                        description: "Contact people easily through their social networks to solve everything 📞",
                                        image: UIImage(named: "OnboardingItem3") ?? UIImage())
  ]
  
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
    
  }
}

// MARK: - Functions
extension OnboardingViewModel {
  func didPressFinishOnboarding() {
    self.router.changeRootToTabBar()
  }
}
