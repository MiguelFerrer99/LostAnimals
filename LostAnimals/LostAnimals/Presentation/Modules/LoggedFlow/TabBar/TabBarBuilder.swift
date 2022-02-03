//
//  TabBarBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 29/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class TabBarBuilder {
    
    func build() -> TabBarViewController {
        
        let viewController = UIViewController.instantiate(viewController: TabBarViewController.self)
        
        let router = TabBarRouter(viewController: viewController)
        let viewModel = TabBarViewModel(router: router)
        
        viewController.viewModel = viewModel
        
        return viewController
    }
}
