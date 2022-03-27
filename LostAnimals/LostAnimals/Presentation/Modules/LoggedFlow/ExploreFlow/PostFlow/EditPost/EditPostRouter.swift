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
    private weak var viewController: EditPostViewController?
    
    // MARK: - Init
    required init(viewController: EditPostViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension EditPostRouter {
    func goBack() {
        self.viewController?.pop()
    }
    
    func goBack2Times() {
        DispatchQueue.main.async {
            guard let viewControllers = self.viewController?.navigationController?.viewControllers else { return }
            let viewController = viewControllers[viewControllers.count - 3]
            self.viewController?.navigationController?.popToViewController(viewController, animated: true)
        }
    }
    
    func goToSelectPhotoPopup(showRemoveOption: Bool) {
        DispatchQueue.main.async {
            let viewController = Container.shared.selectPhotoPopupBuilder().build(showRemoveOption: showRemoveOption, comesFrom: .editPost)
            viewController.delegate = self.viewController
            self.viewController?.present(viewController: viewController, completion: nil)
        }
    }
    
    func goToAnimalTypes(selectedAnimalType: AnimalType) {
        DispatchQueue.main.async {
            let viewController = Container.shared.animalTypesBuilder().build(comesFrom: .editPost)
            viewController.delegate = self.viewController
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func goToWhereCanWeFindYou() {
        DispatchQueue.main.async {
            let viewController = Container.shared.whereCanWeFindYou().build(comesFrom: .editPost)
            viewController.delegate = self.viewController
            self.viewController?.push(viewController: viewController)
        }
    }
}
