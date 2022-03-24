//
//  ErrorPopupBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class ErrorPopupBuilder {}

// MARK: - Functions
extension ErrorPopupBuilder {
    func build(errorTitle: String, action: (() -> Void)? = nil) -> ErrorPopupViewController {
        let viewController = UIViewController.instantiate(viewController: ErrorPopupViewController.self)
        let router = ErrorPopupRouter(viewController: viewController)
        let viewModel = ErrorPopupViewModel(router: router, errorTitle: errorTitle, action: action)
        viewController.viewModel = viewModel
        return viewController
    }
}
