//
//  AnimalFilterPopupBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 2/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class AnimalFilterPopupBuilder {
  
  func build() -> AnimalFilterPopupViewController {
    
    let viewController = UIViewController.instantiate(viewController: AnimalFilterPopupViewController.self)
    
    let router = AnimalFilterPopupRouter(viewController: viewController)
    let viewModel = AnimalFilterPopupViewModel(router: router)
    
    viewController.viewModel = viewModel
    
    return viewController
  }
}
