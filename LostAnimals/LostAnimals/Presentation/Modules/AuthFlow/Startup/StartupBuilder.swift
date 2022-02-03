//
//  StartupBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/11/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class StartupBuilder {
    
    func build() -> StartupViewController {
        
        let viewController = UIViewController.instantiate(viewController: StartupViewController.self)
        
        let router = StartupRouter(viewController: viewController)
        let viewModel = StartupViewModel(router: router)
        
        viewController.viewModel = viewModel
        
        return viewController
    }
}
