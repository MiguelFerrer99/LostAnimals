//
//  OnboardingRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class OnboardingRouter {
  // MARK: - Properties
  private weak var viewController: ViewController?
  
  // MARK: - Init
  required init(viewController: ViewController?) {
    self.viewController = viewController
  }
  
  // MARK: - Functions
  func changeRootToExplore() {
    let viewController = Container.shared.exploreBuilder().build().embeddedInNavigation()
    DispatchQueue.main.async {
      changeRoot(to: viewController)
    }
  }
}
