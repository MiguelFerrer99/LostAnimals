//
//  OnboardingRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class OnboardingRouter {
    // MARK: - Properties
    private weak var viewController: OnboardingViewController?
    
    // MARK: - Init
    required init(viewController: OnboardingViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension OnboardingRouter {
    func changeRootToTabBar() {
        DispatchQueue.main.async {
            let viewController = Container.shared.tabBarBuilder().build()
            changeRoot(to: viewController)
        }
    }
}
