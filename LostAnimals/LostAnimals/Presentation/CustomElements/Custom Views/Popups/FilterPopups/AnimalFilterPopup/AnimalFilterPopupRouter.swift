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
    private weak var viewController: UIViewController?
    
    // MARK: - Init
    required init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    // MARK: - Functions
    func dismissAnimalFilterPopup() {
        DispatchQueue.main.async {
            self.viewController?.dismissCurrentView(completion: nil)
        }
    }
}
