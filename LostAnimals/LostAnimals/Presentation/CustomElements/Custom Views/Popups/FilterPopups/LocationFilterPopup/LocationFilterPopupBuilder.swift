//
//  LocationFilterPopupBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class LocationFilterPopupBuilder {
    
    func build() -> LocationFilterPopupViewController {
        
        let viewController = UIViewController.instantiate(viewController: LocationFilterPopupViewController.self)
        
        let router = LocationFilterPopupRouter(viewController: viewController)
        let viewModel = LocationFilterPopupViewModel(router: router)
        
        viewController.viewModel = viewModel
        
        return viewController
    }
}
