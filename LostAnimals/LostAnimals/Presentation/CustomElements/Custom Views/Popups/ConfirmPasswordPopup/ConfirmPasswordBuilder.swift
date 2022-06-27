//
//  ConfirmPasswordBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 27/6/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class ConfirmPasswordBuilder {}

// MARK: - Functions
extension ConfirmPasswordBuilder {
    func build(completion: @escaping () -> ()) -> ConfirmPasswordViewController {
        let viewController = UIViewController.instantiate(viewController: ConfirmPasswordViewController.self)
        let router = ConfirmPasswordRouter(viewController: viewController)
        let viewModel = ConfirmPasswordViewModel(router: router, completion: completion)
        viewController.viewModel = viewModel
        return viewController
    }
}
