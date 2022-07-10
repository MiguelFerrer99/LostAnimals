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
    private weak var viewController: NewPostGenericViewController?
    
    // MARK: - Init
    required init(viewController: NewPostGenericViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension NewPostGenericRouter {
    func goBack() {
        self.viewController?.pop()
    }
    
    func close() {
        self.viewController?.dismissCurrentView()
    }
    
    func goBackToTabBar() {
        self.viewController?.dismissCurrentView(completion: nil)
    }
    
    func goToSelectPhotoPopup(showRemoveOption: Bool) {
        DispatchQueue.main.async {
            let viewController = Container.shared.selectPhotoPopupBuilder().build(showRemoveOption: showRemoveOption, comesFrom: .newPost)
            viewController.delegate = self.viewController
            self.viewController?.present(viewController: viewController, completion: nil)
        }
    }
    
    func goToAnimalTypes(comesFrom: AnimalTypesComesFrom) {
        DispatchQueue.main.async {
            let viewController = Container.shared.animalTypesBuilder().build(comesFrom: comesFrom)
            viewController.delegate = self.viewController
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func goToWhereCanWeFindYou() {
        DispatchQueue.main.async {
            let viewController = Container.shared.whereCanWeFindYou().build(comesFrom: .newPost)
            viewController.delegate = self.viewController
            self.viewController?.push(viewController: viewController)
        }
    }
}
