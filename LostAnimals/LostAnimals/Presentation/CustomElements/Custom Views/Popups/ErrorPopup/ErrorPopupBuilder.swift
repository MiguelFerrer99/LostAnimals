//
//  ErrorPopupBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class ErrorPopupBuilder {
  
  func build() -> ErrorPopupViewController {
    
    let viewController = UIViewController.instantiate(viewController: ErrorPopupViewController.self)
    
    let router = ErrorPopupRouter(viewController: viewController)
    let viewModel = ErrorPopupViewModel(router: router)
    
    viewController.viewModel = viewModel
    
    return viewController
  }
}
