//
//  ProfileBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 30/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class ProfileBuilder {}

// MARK: - Functions
extension ProfileBuilder {
    func build(user: User) -> ProfileViewController {
        let viewController = UIViewController.instantiate(viewController: ProfileViewController.self)
        let router = ProfileRouter(viewController: viewController)
        let viewModel = ProfileViewModel(router: router, user: user)
        viewController.viewModel = viewModel
        return viewController
    }
}
