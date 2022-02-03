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
}
