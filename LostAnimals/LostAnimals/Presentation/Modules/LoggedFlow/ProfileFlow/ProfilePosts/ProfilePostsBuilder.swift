//
//  ProfilePostsBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class ProfilePostsBuilder {}

// MARK: - Functions
extension ProfilePostsBuilder {
    func build(user: User) -> ProfilePostsViewController {
        let viewController = UIViewController.instantiate(viewController: ProfilePostsViewController.self)
        let router = ProfilePostsRouter(viewController: viewController)
        let viewModel = ProfilePostsViewModel(router: router, user: user)
        viewController.viewModel = viewModel
        return viewController
    }
}
