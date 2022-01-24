//
//  ProfileRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 30/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class ProfileRouter {
  // MARK: - Properties
  private weak var viewController: ViewController?
  
  // MARK: - Init
  required init(viewController: ViewController?) {
    self.viewController = viewController
  }
  
  // MARK: - Functions
  func goBack() {
    DispatchQueue.main.async {
      self.viewController?.pop()
    }
  }
  
  func goToProfileSettings() {
    // TODO: - Go to ProfileSettingsVC
  }
  
  func goToLocation(coordinates: Coordinates, userFirstName: String? = nil) {
    let viewController = Container.shared.locationBuilder().build(coordinates: coordinates, userFirstName: userFirstName)
    DispatchQueue.main.async {
      self.viewController?.push(viewController: viewController)
    }
  }
  
  func changeRootToStartup() {
    let viewController = Container.shared.startupBuilder().build().embeddedInNavigation()
    DispatchQueue.main.async {
      changeRoot(to: viewController)
    }
  }
}
