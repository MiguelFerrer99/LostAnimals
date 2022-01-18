//
//  AnimalTypesBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 5/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class AnimalTypesBuilder {
  
  func build(comesFrom: AnimalTypesComesFrom) -> AnimalTypesViewController {
    
    let viewController = UIViewController.instantiate(viewController: AnimalTypesViewController.self)
    
    let router = AnimalTypesRouter(viewController: viewController)
    let viewModel = AnimalTypesViewModel(router: router, comesFrom: comesFrom)
    
    viewController.viewModel = viewModel
    
    return viewController
  }
}
