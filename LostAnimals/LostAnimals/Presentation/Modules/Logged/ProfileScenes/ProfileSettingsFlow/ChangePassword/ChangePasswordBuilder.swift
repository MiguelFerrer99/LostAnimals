//
//  ChangePasswordBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 5/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class ChangePasswordBuilder {}

// MARK: - Functions
extension ChangePasswordBuilder {
    func build(me: User) -> ChangePasswordViewController {
        let viewController = UIViewController.instantiate(viewController: ChangePasswordViewController.self)
        let router = ChangePasswordRouter(viewController: viewController)
        let viewModel = ChangePasswordViewModel(router: router, me: me)
        viewController.viewModel = viewModel
        return viewController
    }
}
