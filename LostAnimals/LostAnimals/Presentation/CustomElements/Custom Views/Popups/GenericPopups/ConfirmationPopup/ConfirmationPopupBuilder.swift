//
//  ConfirmationPopupBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 22/3/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class ConfirmationPopupBuilder {}

// MARK: - Functions
extension ConfirmationPopupBuilder {
    func build(title: String, yesAction: (() -> Void)? = nil) -> ConfirmationPopupViewController {
        let viewController = UIViewController.instantiate(viewController: ConfirmationPopupViewController.self)
        let router = ConfirmationPopupRouter(viewController: viewController)
        let viewModel = ConfirmationPopupViewModel(router: router, titleText: title, yesAction: yesAction)
        viewController.viewModel = viewModel
        return viewController
    }
}
