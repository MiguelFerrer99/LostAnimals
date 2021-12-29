//
//  WhereCanWeFindYouRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 19/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class WhereCanWeFindYouRouter {
  // MARK: - Properties
  private weak var viewController: ViewController?
  
  // MARK: - Init
  required init(viewController: ViewController?) {
    self.viewController = viewController
  }
  
  // MARK: - Functions
  func goToSignUp() {
    guard let viewController = self.viewController?.navigationController?.viewControllers[1] as? SignUpViewController else { return }
    DispatchQueue.main.async {
      self.viewController?.navigationController?.popToViewController(viewController, animated: true)
    }
  }
}
