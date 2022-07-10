//
//  MyPetRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/7/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class MyPetRouter {
    // MARK: - Properties
    private weak var viewController: MyPetViewController?
    
    // MARK: - Init
    required init(viewController: MyPetViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension MyPetRouter {
    func goBack() {
        self.viewController?.dismissCurrentView()
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
    
    func dismissAndGoToNewLostPost(postToLoad: Post) {
        DispatchQueue.main.async {
            self.viewController?.dismissCurrentView(completion: {
                self.viewController?.delegate?.openNewPost(postToLoad: postToLoad)
            })
        }
    }
}
