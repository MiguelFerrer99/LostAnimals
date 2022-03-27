//
//  AnimalFilterPopupRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 2/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class AnimalFilterPopupRouter {
    // MARK: - Properties
    private weak var viewController: AnimalFilterPopupViewController?
    
    // MARK: - Init
    required init(viewController: AnimalFilterPopupViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension AnimalFilterPopupRouter {
    func dismissAnimalFilterPopup() {
        self.viewController?.dismissCurrentView(completion: nil)
    }
}
