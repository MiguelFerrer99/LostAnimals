//
//  BlockedUsersBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class BlockedUsersBuilder {
    
    func build() -> BlockedUsersViewController {
        let viewController = UIViewController.instantiate(viewController: BlockedUsersViewController.self)
        
        let router = BlockedUsersRouter(viewController: viewController)
        let viewModel = BlockedUsersViewModel(router: router)
        
        viewController.viewModel = viewModel
        
        return viewController
    }
}
