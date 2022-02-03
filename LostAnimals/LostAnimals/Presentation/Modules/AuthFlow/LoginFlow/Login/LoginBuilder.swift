//
//  LoginBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 22/11/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class LoginBuilder {
    
    func build() -> LoginViewController {
        
        let viewController = UIViewController.instantiate(viewController: LoginViewController.self)
        
        let router = LoginRouter(viewController: viewController)
        let viewModel = LoginViewModel(router: router)
        
        viewController.viewModel = viewModel
        
        return viewController
    }
}
