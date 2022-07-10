//
//  OnboardingBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class OnboardingBuilder {}

// MARK: - Functions
extension OnboardingBuilder {
    func build() -> OnboardingViewController {
        let viewController = UIViewController.instantiate(viewController: OnboardingViewController.self)
        let router = OnboardingRouter(viewController: viewController)
        let viewModel = OnboardingViewModel(router: router)
        viewController.viewModel = viewModel
        return viewController
    }
}
