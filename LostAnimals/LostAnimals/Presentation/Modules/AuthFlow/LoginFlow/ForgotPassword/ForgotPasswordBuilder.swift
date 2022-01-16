//
//  ForgotPasswordBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class ForgotPasswordBuilder {
  
  func build() -> ForgotPasswordViewController {
    
    let viewController = UIViewController.instantiate(viewController: ForgotPasswordViewController.self)
    
    let router = ForgotPasswordRouter(viewController: viewController)
    let viewModel = ForgotPasswordViewModel(router: router)
    
    viewController.viewModel = viewModel
    
    return viewController
  }
}
