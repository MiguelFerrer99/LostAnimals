//
//  ProfileBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 30/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class ProfileBuilder {
  
  func build() -> ProfileViewController {
    
    let viewController = UIViewController.instantiate(viewController: ProfileViewController.self)
    
    let router = ProfileRouter(viewController: viewController)
    let viewModel = ProfileViewModel(router: router)
    
    viewController.viewModel = viewModel
    
    return viewController
  }
}
