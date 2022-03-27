//
//  GuestPopupRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class GuestPopupRouter {
    // MARK: - Properties
    private weak var viewController: GuestPopupViewController?
    
    // MARK: - Init
    required init(viewController: GuestPopupViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension GuestPopupRouter {
    func dismissGuestPopup() {
        self.viewController?.dismissCurrentView(completion: nil)
    }
    
    func changeRootToStartup() {
        DispatchQueue.main.async {
            let viewController = Container.shared.startupBuilder().build().embeddedInNavigation()
            changeRoot(to: viewController)
        }
    }
}
