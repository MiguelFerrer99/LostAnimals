//
//  WhereDoYouLiveCitiesBuilder.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 11/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class WhereDoYouLiveCitiesBuilder {
  
  func build(country: Country, cities: [String]) -> WhereDoYouLiveCitiesViewController {
    
    let viewController = UIViewController.instantiate(viewController: WhereDoYouLiveCitiesViewController.self)
    
    let router = WhereDoYouLiveCitiesRouter(viewController: viewController)
    let viewModel = WhereDoYouLiveCitiesViewModel(router: router, country: country, cities: cities)
    
    viewController.viewModel = viewModel
    
    return viewController
  }
}
