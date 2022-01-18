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
  
  func goBack2Times() {
    guard let viewControllers = self.viewController?.navigationController?.viewControllers else { return }
    let viewController = viewControllers[viewControllers.count - 3]
    DispatchQueue.main.async {
      self.viewController?.navigationController?.popToViewController(viewController, animated: true)
    }
  }
  
  func goToSelectPhotoPopup(showRemoveOption: Bool) {
    let viewController = Container.shared.selectPhotoPopupBuilder().build(showRemoveOption: showRemoveOption, comesFrom: .editPost)
    DispatchQueue.main.async {
      self.viewController?.present(viewController: viewController, completion: nil)
    }
  }
  
  func goToAnimalTypes(selectedAnimalType: AnimalType) {
    let viewController = Container.shared.animalTypesBuilder().build(comesFrom: .editPost)
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
