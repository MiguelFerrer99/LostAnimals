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
        DispatchQueue.main.async {
            self.viewController?.pop()
        }
    }
    
    func goToWhereDoYouLiveCountries(comesFrom: WhereDoYouLiveComesFrom) {
        let viewController = Container.shared.whereDoYouLiveCountriesBuilder().build(comesFrom: comesFrom)
        viewController.delegate = self.viewController
        DispatchQueue.main.async {
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func goToWhereCanWeFindYou() {
        let viewController = Container.shared.whereCanWeFindYou().build(comesFrom: .signUp)
        viewController.delegate = self.viewController
        DispatchQueue.main.async {
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func goToTermsAndConditions() {
        let viewController = Container.shared.termsAndConditionsBuilder().build()
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
