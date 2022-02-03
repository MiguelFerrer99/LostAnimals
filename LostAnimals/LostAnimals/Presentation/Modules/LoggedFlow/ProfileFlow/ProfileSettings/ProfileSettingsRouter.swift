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
    
    func goToSelectPhotoPopup(showRemoveOption: Bool) {
        let viewController = Container.shared.selectPhotoPopupBuilder().build(showRemoveOption: showRemoveOption, comesFrom: .profileSettings)
        DispatchQueue.main.async {
            self.viewController?.present(viewController: viewController, completion: nil)
        }
    }
    
    func goToEditPersonalData() {
        // TODO: Create EditPersonalData module
    }
    
    func goToEditSocialMedias() {
        // TODO: Create EditSocialMedias module
    }
    
    func goToChangePassword() {
        // TODO: Create ChangePassword module
    }
    
    func goToBlockedUsers() {
        // TODO: Create BlockedUsers module
    }
    
    func goToTermsAndConditions() {
        let viewController = Container.shared.termsAndConditionsBuilder().build()
        DispatchQueue.main.async {
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func changeRootToStartup() {
        let viewController = Container.shared.startupBuilder().build().embeddedInNavigation()
        DispatchQueue.main.async {
            changeRoot(to: viewController)
        }
    }
}
