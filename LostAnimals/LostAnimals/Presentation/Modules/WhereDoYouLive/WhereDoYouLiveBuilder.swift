//
//  WhereDoYouLiveBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 10/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class WhereDoYouLiveBuilder {
  
  func build() -> WhereDoYouLiveViewController {
    
    let viewController = UIViewController.instantiate(viewController: WhereDoYouLiveViewController.self)
    
    let router = WhereDoYouLiveRouter(viewController: viewController)
    let viewModel = WhereDoYouLiveViewModel(router: router)
    
    viewController.viewModel = viewModel
    
    return viewController
  }
}
