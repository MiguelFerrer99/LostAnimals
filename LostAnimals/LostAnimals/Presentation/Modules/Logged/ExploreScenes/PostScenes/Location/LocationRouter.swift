//
//  LocationRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class LocationRouter {
    // MARK: - Properties
    private weak var viewController: LocationViewController?
    
    // MARK: - Init
    required init(viewController: LocationViewController?) {
        self.viewController = viewController
    }
}
