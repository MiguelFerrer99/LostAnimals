//
//  SuccessPopupRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class SuccessPopupRouter {
    // MARK: - Properties
    private weak var viewController: SuccessPopupViewController?
    
    // MARK: - Init
    required init(viewController: SuccessPopupViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension SuccessPopupRouter {
    func dismissSuccessPopup(action: ()? = nil) {
        DispatchQueue.main.async {
            self.viewController?.dismissCurrentView(completion: {
                if let action = action { action }
            })
        }
    }
}
