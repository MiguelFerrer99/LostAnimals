//
//  TermsAndConditionsBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class TermsAndConditionsBuilder {}

// MARK: - Functions
extension TermsAndConditionsBuilder {
    func build() -> TermsAndConditionsViewController {
        let viewController = UIViewController.instantiate(viewController: TermsAndConditionsViewController.self)
        let router = TermsAndConditionsRouter(viewController: viewController)
        let viewModel = TermsAndConditionsViewModel(router: router)
        viewController.viewModel = viewModel
        return viewController
    }
}
