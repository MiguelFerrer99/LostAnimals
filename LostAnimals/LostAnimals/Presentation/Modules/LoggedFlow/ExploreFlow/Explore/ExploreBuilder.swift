//
//  ExploreBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 29/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class ExploreBuilder {
    
    func build() -> ExploreViewController {
        
        let viewController = UIViewController.instantiate(viewController: ExploreViewController.self)
        
        let router = ExploreRouter(viewController: viewController)
        let viewModel = ExploreViewModel(router: router)
        
        viewController.viewModel = viewModel
        
        return viewController
    }
}
