//
//  WhereDoYouLiveCountriesRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 10/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class WhereDoYouLiveCountriesRouter {
  // MARK: - Properties
  private weak var viewController: UIViewController?
  
  // MARK: - Init
  required init(viewController: UIViewController?) {
    self.viewController = viewController
  }
  
  // MARK: - Functions
  func goToSignUp() {
    DispatchQueue.main.async {
      self.viewController?.navigationController?.popViewController(animated: true)
    }
  }
  
  func goToWhereDoYouLiveCities(country: Country, cities: [String]) {
    let viewController = Container.shared.whereDoYouLiveCitiesBuilder().build(country: country, cities: cities)
    DispatchQueue.main.async {
      self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
  }
}
