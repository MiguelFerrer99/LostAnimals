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
  private weak var viewController: UIViewController?
  
  // MARK: - Init
  required init(viewController: UIViewController?) {
    self.viewController = viewController
  }
  
  // MARK: - Functions
  func goToLogin() {
    let viewController = Container.shared.loginBuilder().build()
    DispatchQueue.main.async {
      self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
  }
}
