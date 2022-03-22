//
//  WhereDoYouLiveCitiesBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 11/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class WhereDoYouLiveCitiesBuilder {}

// MARK: - Functions
extension WhereDoYouLiveCitiesBuilder {
    func build(comesFrom: WhereDoYouLiveComesFrom, country: Country, cities: [String]) -> WhereDoYouLiveCitiesViewController {
        let viewController = UIViewController.instantiate(viewController: WhereDoYouLiveCitiesViewController.self)
        let router = WhereDoYouLiveCitiesRouter(viewController: viewController)
        let viewModel = WhereDoYouLiveCitiesViewModel(router: router, comesFrom: comesFrom, country: country, cities: cities)
        viewController.viewModel = viewModel
        return viewController
    }
}
