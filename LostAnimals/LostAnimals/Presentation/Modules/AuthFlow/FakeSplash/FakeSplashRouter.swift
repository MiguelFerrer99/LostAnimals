//
//  FakeSplashRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 27/3/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class FakeSplashRouter {
    // MARK: - Properties
    private weak var viewController: FakeSplashViewController?
    
    // MARK: - Init
    required init(viewController: FakeSplashViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension FakeSplashRouter {
    func goToStartup() {
        DispatchQueue.main.async {
            let viewController = Container.shared.startupBuilder().build().embeddedInNavigation()
            changeRoot(to: viewController)
        }
    }
    
    func goToOnboarding() {
        DispatchQueue.main.async {
            let viewController = Container.shared.onboardingBuilder().build()
            changeRoot(to: viewController)
        }
    }
    
    func goToTabBar() {
        DispatchQueue.main.async {
            let viewController = Container.shared.tabBarBuilder().build()
            changeRoot(to: viewController)
        }
    }
}
