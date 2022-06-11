//
//  AnimalFilterPopupBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 2/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class AnimalFilterPopupBuilder {}

// MARK: - Functions
extension AnimalFilterPopupBuilder {
    func build(loadData: Bool) -> AnimalFilterPopupViewController {
        let viewController = UIViewController.instantiate(viewController: AnimalFilterPopupViewController.self)
        let router = AnimalFilterPopupRouter(viewController: viewController)
        let viewModel = AnimalFilterPopupViewModel(router: router, loadData: loadData)
        viewController.viewModel = viewModel
        return viewController
    }
}
