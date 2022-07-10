//
//  FakeSplashBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 27/3/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class FakeSplashBuilder {}

// MARK: - Functions
extension FakeSplashBuilder {
    func build() -> FakeSplashViewController {
        let viewController = UIViewController.instantiate(viewController: FakeSplashViewController.self)
        let router = FakeSplashRouter(viewController: viewController)
        let viewModel = FakeSplashViewModel(router: router)
        viewController.viewModel = viewModel
        return viewController
    }
}
