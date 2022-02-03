//
//  SignUpBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class SignUpBuilder {
    
    func build() -> SignUpViewController {
        
        let viewController = UIViewController.instantiate(viewController: SignUpViewController.self)
        
        let router = SignUpRouter(viewController: viewController)
        let viewModel = SignUpViewModel(router: router)
        
        viewController.viewModel = viewModel
        
        return viewController
    }
}
