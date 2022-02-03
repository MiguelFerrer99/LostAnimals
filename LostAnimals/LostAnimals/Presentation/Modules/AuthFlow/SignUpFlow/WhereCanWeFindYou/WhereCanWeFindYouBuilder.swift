//
//  WhereCanWeFindYouBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 19/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class WhereCanWeFindYouBuilder {
    
    func build(comesFrom: WhereCanWeFindYouComesFrom) -> WhereCanWeFindYouViewController {
        
        let viewController = UIViewController.instantiate(viewController: WhereCanWeFindYouViewController.self)
        
        let router = WhereCanWeFindYouRouter(viewController: viewController)
        let viewModel = WhereCanWeFindYouViewModel(router: router, comesFrom: comesFrom)
        
        viewController.viewModel = viewModel
        
        return viewController
    }
}
