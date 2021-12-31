//
//  StartupRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/11/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class StartupRouter {
  // MARK: - Properties
  private weak var viewController: ViewController?
  
  // MARK: - Init
  required init(viewController: ViewController?) {
    self.viewController = viewController
  }
  
  // MARK: - Functions
  func goToLogin() {
    let viewController = Container.shared.loginBuilder().build()
    DispatchQueue.main.async {
      self.viewController?.push(viewController: viewController)
    }
  }
  
  func gotoSignup() {
    let viewController = Container.shared.signupBuilder().build()
    DispatchQueue.main.async {
      self.viewController?.push(viewController: viewController)
    }
  }
  
  func goToOnboarding() {
    let viewController = Container.shared.onboardingBuilder().build()
    DispatchQueue.main.async {
      self.viewController?.present(viewController: viewController, completion: nil)
    }
  }
  
  func changeRootToTabBar() {
    let viewController = Container.shared.tabBarBuilder().build()
    DispatchQueue.main.async {
      changeRoot(to: viewController)
    }
  }
}
