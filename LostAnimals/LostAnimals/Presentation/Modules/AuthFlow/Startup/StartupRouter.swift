//
//  StartupRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/11/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class StartupRouter {
    // MARK: - Properties
    private weak var viewController: StartupViewController?
    
    // MARK: - Init
    required init(viewController: StartupViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension StartupRouter {
    func goToLogin() {
        DispatchQueue.main.async {
            let viewController = Container.shared.loginBuilder().build()
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func gotoSignup() {
        DispatchQueue.main.async {
            let viewController = Container.shared.signupBuilder().build()
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func goToOnboarding() {
        DispatchQueue.main.async {
            let viewController = Container.shared.onboardingBuilder().build()
            self.viewController?.present(viewController: viewController, completion: nil)
        }
    }
    
    func changeRootToTabBar() {
        DispatchQueue.main.async {
            let viewController = Container.shared.tabBarBuilder().build()
            changeRoot(to: viewController)
        }
    }
}
