//
//  ProfileSettingsRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 25/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class ProfileSettingsRouter {
    // MARK: - Properties
    private weak var viewController: ViewController?
    
    // MARK: - Init
    required init(viewController: ViewController?) {
        self.viewController = viewController
    }
    
    // MARK: - Functions
    func goBack() {
        DispatchQueue.main.async {
            self.viewController?.pop()
        }
    }
    
    func goToEditPersonalData() {
        DispatchQueue.main.async {
            self.viewController?.pop()
        }
    }
    
    func goToEditSocialMedias() {
        DispatchQueue.main.async {
            self.viewController?.pop()
        }
    }
    
    func goToChangePassword() {
        DispatchQueue.main.async {
            self.viewController?.pop()
        }
    }
    
    func goToBlockedUsers() {
        DispatchQueue.main.async {
            self.viewController?.pop()
        }
    }
    
    func goToTermsAndConditions() {
        DispatchQueue.main.async {
            self.viewController?.pop()
        }
    }
    
    func changeRootToStartup() {
        let viewController = Container.shared.startupBuilder().build().embeddedInNavigation()
        DispatchQueue.main.async {
            changeRoot(to: viewController)
        }
    }
}
