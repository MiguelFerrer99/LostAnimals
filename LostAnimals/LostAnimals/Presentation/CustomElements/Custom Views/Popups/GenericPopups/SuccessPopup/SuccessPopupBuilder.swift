//
//  SuccessPopupBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class SuccessPopupBuilder {}

// MARK: - Functions
extension SuccessPopupBuilder {
    func build(successTitle: String, action: (() -> Void)? = nil) -> SuccessPopupViewController {
        let viewController = UIViewController.instantiate(viewController: SuccessPopupViewController.self)
        let router = SuccessPopupRouter(viewController: viewController)
        let viewModel = SuccessPopupViewModel(router: router, successTitle: successTitle, action: action)
        viewController.viewModel = viewModel
        return viewController
    }
}
