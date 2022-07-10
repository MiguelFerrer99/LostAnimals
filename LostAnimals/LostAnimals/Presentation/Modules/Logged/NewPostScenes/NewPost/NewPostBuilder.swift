//
//  NewPostBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 29/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class NewPostBuilder {}

// MARK: - NewPostBuilder
extension NewPostBuilder {
    func build() -> NewPostViewController {
        let viewController = UIViewController.instantiate(viewController: NewPostViewController.self)
        let router = NewPostRouter(viewController: viewController)
        let viewModel = NewPostViewModel(router: router)
        viewController.viewModel = viewModel
        return viewController
    }
}
