//
//  SuccessPopupBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class SuccessPopupBuilder {
  
  func build(successTitle: String) -> SuccessPopupViewController {
    
    let viewController = UIViewController.instantiate(viewController: SuccessPopupViewController.self)
    
    let router = SuccessPopupRouter(viewController: viewController)
    let viewModel = SuccessPopupViewModel(router: router, successTitle: successTitle)
    
    viewController.viewModel = viewModel
    
    return viewController
  }
}
