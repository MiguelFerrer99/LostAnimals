//
//  ChangePasswordBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 5/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class ChangePasswordBuilder {
    
    func build() -> ChangePasswordViewController {
        let viewController = UIViewController.instantiate(viewController: ChangePasswordViewController.self)
        
        let router = ChangePasswordRouter(viewController: viewController)
        let viewModel = ChangePasswordViewModel(router: router)
        
        viewController.viewModel = viewModel
        
        return viewController
    }
}
