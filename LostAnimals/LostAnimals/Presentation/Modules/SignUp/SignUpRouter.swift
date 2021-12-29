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
  private weak var viewController: ViewController?
  
  // MARK: - Init
  required init(viewController: ViewController?) {
    self.viewController = viewController
  }
  
  // MARK: - Functions
  func goToWhereDoYouLiveCountries(comesFrom: WhereDoYouLiveComesFrom) {
    let viewController = Container.shared.whereDoYouLiveCountriesBuilder().build(comesFrom: comesFrom)
    DispatchQueue.main.async {
      self.viewController?.push(viewController: viewController)
    }
  }
  
  func goToWhereCanWeFindYou() {
    let viewController = Container.shared.whereCanWeFindYou().build()
    DispatchQueue.main.async {
      self.viewController?.push(viewController: viewController)
    }
  }
  
  func goToTermsAndConditions() {
    let viewController = Container.shared.termsAndConditionsBuilder().build()
    DispatchQueue.main.async {
      self.viewController?.push(viewController: viewController)
    }
  }
  
  func goToOnboarding() {
    let viewController = Container.shared.onboardingBuilder().build()
    DispatchQueue.main.async {
      self.viewController?.presentWithNavBar(viewController: viewController, completion: nil)
    }
  }
}
