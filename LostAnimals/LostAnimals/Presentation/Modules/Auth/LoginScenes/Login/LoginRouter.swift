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
        DispatchQueue.main.async {
            let viewController = Container.shared.forgotPasswordBuilder().build()
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
