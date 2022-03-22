//
//  ProfileSettingsBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 25/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class ProfileSettingsBuilder {}

// MARK: - Functions
extension ProfileSettingsBuilder {
    func build(me: User) -> ProfileSettingsViewController {
        let viewController = UIViewController.instantiate(viewController: ProfileSettingsViewController.self)
        let router = ProfileSettingsRouter(viewController: viewController)
        let viewModel = ProfileSettingsViewModel(router: router, me: me)
        viewController.viewModel = viewModel
        return viewController
    }
}
