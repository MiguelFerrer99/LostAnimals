//
//  SignUpRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class SignUpRouter {
    // MARK: - Properties
    private weak var viewController: SignUpViewController?
    
    // MARK: - Init
    required init(viewController: SignUpViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension SignUpRouter {
    func goBack() {
        self.viewController?.pop()
    }
    
    func goToWhereDoYouLiveCountries(comesFrom: WhereDoYouLiveComesFrom) {
        DispatchQueue.main.async {
            let viewController = Container.shared.whereDoYouLiveCountriesBuilder().build(comesFrom: comesFrom)
            viewController.delegate = self.viewController
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func goToWhereCanWeFindYou() {
        DispatchQueue.main.async {
            let viewController = Container.shared.whereCanWeFindYou().build(comesFrom: .signUp)
            viewController.delegate = self.viewController
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func goToTermsAndConditions() {
        DispatchQueue.main.async {
            let viewController = Container.shared.termsAndConditionsBuilder().build()
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
