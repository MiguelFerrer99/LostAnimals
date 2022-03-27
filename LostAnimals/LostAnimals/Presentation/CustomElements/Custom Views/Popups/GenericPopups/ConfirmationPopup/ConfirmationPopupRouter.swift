//
//  ConfirmationPopupRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 22/3/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class ConfirmationPopupRouter {
    // MARK: - Properties
    private weak var viewController: ConfirmationPopupViewController?
    
    // MARK: - Init
    required init(viewController: ConfirmationPopupViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension ConfirmationPopupRouter {
    func dismissConfirmationPopup(yesAction: (() -> Void)? = nil) {
        self.viewController?.dismissCurrentView(completion: {
            if let yesAction = yesAction { yesAction() }
        })
    }
}
