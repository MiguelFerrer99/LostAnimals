//
//  ContactWithPopupBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class ContactWithPopupBuilder {
  
  func build() -> ContactWithPopupViewController {
    
    let viewController = UIViewController.instantiate(viewController: ContactWithPopupViewController.self)
    
    let router = ContactWithPopupRouter(viewController: viewController)
    let viewModel = ContactWithPopupViewModel(router: router)
    
    viewController.viewModel = viewModel
    
    return viewController
  }
}
