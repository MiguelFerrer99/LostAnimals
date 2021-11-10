//
//  ScrollViewExampleBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 10/11/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class ScrollViewExampleBuilder {
  
  func build() -> ScrollViewExampleViewController {
    
    let viewController = UIViewController.instantiate(viewController: ScrollViewExampleViewController.self)
    
    let router = ScrollViewExampleRouter(viewController: viewController)
    let viewModel = ScrollViewExampleViewModel(router: router)
    
    viewController.viewModel = viewModel
    
    return viewController
  }
}
