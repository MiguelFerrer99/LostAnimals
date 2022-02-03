//
//  WhereDoYouLiveCountriesBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 10/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class WhereDoYouLiveCountriesBuilder {
    
    func build(comesFrom: WhereDoYouLiveComesFrom) -> WhereDoYouLiveCountriesViewController {
        
        let viewController = UIViewController.instantiate(viewController: WhereDoYouLiveCountriesViewController.self)
        
        let router = WhereDoYouLiveCountriesRouter(viewController: viewController)
        
        let viewModel = WhereDoYouLiveCountriesViewModel(router: router, comesFrom: comesFrom)
        
        viewController.viewModel = viewModel
        
        return viewController
    }
}
