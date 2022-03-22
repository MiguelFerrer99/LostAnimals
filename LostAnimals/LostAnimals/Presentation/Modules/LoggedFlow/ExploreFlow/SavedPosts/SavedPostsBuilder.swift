//
//  SavedPostsBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class SavedPostsBuilder {}

// MARK: - Functions
extension SavedPostsBuilder {
    func build() -> SavedPostsViewController {
        let viewController = UIViewController.instantiate(viewController: SavedPostsViewController.self)
        let router = SavedPostsRouter(viewController: viewController)
        let viewModel = SavedPostsViewModel(router: router)
        viewController.viewModel = viewModel
        return viewController
    }
}
