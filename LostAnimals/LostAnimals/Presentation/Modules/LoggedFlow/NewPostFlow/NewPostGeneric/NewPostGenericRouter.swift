//
//  NewPostGenericRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 17/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class NewPostGenericRouter {
  // MARK: - Properties
  private weak var viewController: ViewController?
  
  // MARK: - Init
  required init(viewController: ViewController?) {
    self.viewController = viewController
  }
  
  // MARK: - Functions
  func goBackToTabBar() {
    DispatchQueue.main.async {
      self.viewController?.dismissCurrentView(completion: nil)
    }
  }
  
  func goToSelectPhotoPopup(showRemoveOption: Bool) {
    let viewController = Container.shared.selectPhotoPopupBuilder().build(showRemoveOption: showRemoveOption, comesFrom: .newPost)
    DispatchQueue.main.async {
      self.viewController?.present(viewController: viewController, completion: nil)
    }
  }
  
  func goToAnimalTypes(comesFrom: AnimalTypesComesFrom) {
    let viewController = Container.shared.animalTypesBuilder().build(comesFrom: comesFrom)
    DispatchQueue.main.async {
      self.viewController?.push(viewController: viewController)
    }
  }
  
  func goToWhereCanWeFindYou() {
    let viewController = Container.shared.whereCanWeFindYou().build(comesFrom: .newPost)
    DispatchQueue.main.async {
      self.viewController?.push(viewController: viewController)
    }
  }
}
