//
//  ChangePasswordRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 5/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class ChangePasswordRouter {
    // MARK: - Properties
    private weak var viewController: ChangePasswordViewController?
    
    // MARK: - Init
    required init(viewController: ChangePasswordViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension ChangePasswordRouter {
    func goBack() {
        self.viewController?.pop()
    }
}
