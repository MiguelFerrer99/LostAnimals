//
//  LocationBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class LocationBuilder {
    
    func build(coordinates: Coordinates, animal: Animal? = nil, userFirstName: String? = nil) -> LocationViewController {
        
        let viewController = UIViewController.instantiate(viewController: LocationViewController.self)
        
        let router = LocationRouter(viewController: viewController)
        let viewModel = LocationViewModel(router: router, coordinates: coordinates, animal: animal, userFirstName: userFirstName)
        
        viewController.viewModel = viewModel
        
        return viewController
    }
}
