//
//  LocationFilterPopupBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class LocationFilterPopupBuilder {}

// MARK: - Functions
extension LocationFilterPopupBuilder {
    func build(loadData: Bool) -> LocationFilterPopupViewController {
        let viewController = UIViewController.instantiate(viewController: LocationFilterPopupViewController.self)
        let router = LocationFilterPopupRouter(viewController: viewController)
        let viewModel = LocationFilterPopupViewModel(router: router, loadData: loadData)
        viewController.viewModel = viewModel
        return viewController
    }
}
