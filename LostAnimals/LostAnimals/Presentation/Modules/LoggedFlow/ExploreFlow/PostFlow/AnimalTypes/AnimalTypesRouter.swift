//
//  AnimalTypesRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 5/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class AnimalTypesRouter {
    // MARK: - Properties
    private weak var viewController: AnimalTypesViewController?
    
    // MARK: - Init
    required init(viewController: AnimalTypesViewController?) {
        self.viewController = viewController
    }
    
    // MARK: - Functions
    func goBack(with animalType: AnimalType) {
        DispatchQueue.main.async {
            self.viewController?.delegate?.getAnimalType(animalType: animalType)
            self.viewController?.pop()
        }
    }
}
