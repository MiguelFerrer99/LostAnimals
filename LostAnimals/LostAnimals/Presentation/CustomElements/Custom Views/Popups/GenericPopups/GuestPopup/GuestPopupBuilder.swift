//
//  GuestPopupBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class GuestPopupBuilder {
    
    func build() -> GuestPopupViewController {
        
        let viewController = UIViewController.instantiate(viewController: GuestPopupViewController.self)
        
        let router = GuestPopupRouter(viewController: viewController)
        let viewModel = GuestPopupViewModel(router: router)
        
        viewController.viewModel = viewModel
        
        return viewController
    }
}
