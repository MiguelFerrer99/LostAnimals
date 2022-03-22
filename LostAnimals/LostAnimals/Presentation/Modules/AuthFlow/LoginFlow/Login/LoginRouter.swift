//
//  LoginRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 22/11/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class LoginRouter {
    // MARK: - Properties
    private weak var viewController: LoginViewController?
    
    // MARK: - Init
    required init(viewController: LoginViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension LoginRouter {
    func goToForgotPassword() {
        let viewController = Container.shared.forgotPasswordBuilder().build()
        DispatchQueue.main.async {
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func goToOnboarding() {
        let viewController = Container.shared.onboardingBuilder().build()
        DispatchQueue.main.async {
            self.viewController?.present(viewController: viewController, completion: nil)
        }
    }
    
    func changeRootToTabBar() {
        let viewController = Container.shared.tabBarBuilder().build()
        DispatchQueue.main.async {
            changeRoot(to: viewController)
        }
    }
}
