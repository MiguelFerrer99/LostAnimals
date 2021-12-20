//
//  SignUpRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class SignUpRouter {
  // MARK: - Properties
  private weak var viewController: UIViewController?
  
  // MARK: - Init
  required init(viewController: UIViewController?) {
    self.viewController = viewController
  }
  
  // MARK: - Functions
  func goToWhereDoYouLiveCountries() {
    let viewController = Container.shared.whereDoYouLiveCountriesBuilder().build()
    DispatchQueue.main.async {
      self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
  }
  
  func goToWhereCanWeFindYou() {
    let viewController = Container.shared.whereCanWeFindYou().build()
    DispatchQueue.main.async {
      self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
  }
}
