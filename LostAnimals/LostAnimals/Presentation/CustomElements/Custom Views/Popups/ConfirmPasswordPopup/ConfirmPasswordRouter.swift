//
//  ConfirmPasswordRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 27/6/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class ConfirmPasswordRouter {
    // MARK: - Properties
    private weak var viewController: ConfirmPasswordViewController?
    
    // MARK: - Init
    required init(viewController: ConfirmPasswordViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension ConfirmPasswordRouter {
    func dismiss(completion: (() -> Void)? = nil) {
        self.viewController?.dismissCurrentView(completion: {
            if let completion = completion { completion() }
        })
    }
}
