//
//  LocationFilterPopupRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class LocationFilterPopupRouter {
    // MARK: - Properties
    private weak var viewController: LocationFilterPopupViewController?
    
    // MARK: - Init
    required init(viewController: LocationFilterPopupViewController?) {
        self.viewController = viewController
    }
    
    // MARK: - Functions
    func dismissLocationFilterPopup() {
        DispatchQueue.main.async {
            self.viewController?.dismissCurrentView(completion: nil)
        }
    }
}
