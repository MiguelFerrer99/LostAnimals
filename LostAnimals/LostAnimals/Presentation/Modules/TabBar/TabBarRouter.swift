//
//  TabBarRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 29/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class TabBarRouter {
  // MARK: - Properties
  private weak var viewController: UIViewController?
  
  // MARK: - Init
  required init(viewController: UIViewController?) {
    self.viewController = viewController
  }
  
  // MARK: - Functions
  func goToExplore() -> ViewController {
    return Container.shared.exploreBuilder().build()
  }
  
  func goToNewPost() {
    let viewController = Container.shared.newPostBuilder().build()
    DispatchQueue.main.async {
      self.viewController?.present(viewController: viewController, completion: nil)
    }
  }
  
  func goToProfile() -> ViewController {
    return Container.shared.profileBuilder().build()
  }
}
