//
//  EditPostRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 4/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class EditPostRouter {
  // MARK: - Properties
  private weak var viewController: ViewController?
  
  // MARK: - Init
  required init(viewController: ViewController?) {
    self.viewController = viewController
  }
  
  // MARK: - Functions
  func goBack() {
    self.viewController?.pop()
  }
  
  func goToAnimalTypes(selectedAnimalType: AnimalType) {
    let viewController = Container.shared.animalTypesBuilder().build(selectedAnimalType: selectedAnimalType)
    DispatchQueue.main.async {
      self.viewController?.push(viewController: viewController)
    }
  }
  
  func goToWhereCanWeFindYou() {
    let viewController = Container.shared.whereCanWeFindYou().build(comesFrom: .editPost)
    DispatchQueue.main.async {
      self.viewController?.push(viewController: viewController)
    }
  }
}
