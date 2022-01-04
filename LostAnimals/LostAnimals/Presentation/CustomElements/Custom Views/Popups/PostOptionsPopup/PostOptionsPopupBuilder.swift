//
//  PostOptionsPopupBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class PostOptionsPopupBuilder {
  
  func build() -> PostOptionsPopupViewController {
    
    let viewController = UIViewController.instantiate(viewController: PostOptionsPopupViewController.self)
    
    let router = PostOptionsPopupRouter(viewController: viewController)
    let viewModel = PostOptionsPopupViewModel(router: router)
    
    viewController.viewModel = viewModel
    
    return viewController
  }
}
