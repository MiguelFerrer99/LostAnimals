//
//  ErrorPopupRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class ErrorPopupRouter {
    // MARK: - Properties
    private weak var viewController: ErrorPopupViewController?
    
    // MARK: - Init
    required init(viewController: ErrorPopupViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension ErrorPopupRouter {
    func dismissErrorPopup(action: ()? = nil) {
        DispatchQueue.main.async {
            self.viewController?.dismissCurrentView(completion: {
                if let action = action { action }
            })
        }
    }
}
