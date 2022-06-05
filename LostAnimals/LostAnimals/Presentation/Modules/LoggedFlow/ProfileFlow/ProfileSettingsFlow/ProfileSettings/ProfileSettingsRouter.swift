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
    private weak var viewController: ProfileSettingsViewController?
    
    // MARK: - Init
    required init(viewController: ProfileSettingsViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension ProfileSettingsRouter {
    func goBack() {
        self.viewController?.pop()
    }
    
    func goToSelectPhotoPopup(showRemoveOption: Bool) {
        DispatchQueue.main.async {
            let viewController = Container.shared.selectPhotoPopupBuilder().build(showRemoveOption: showRemoveOption, comesFrom: .profileSettings)
            viewController.delegate = self.viewController
            self.viewController?.present(viewController: viewController, completion: nil)
        }
    }
    
    func goToEditPersonalDetails(me: User) {
        DispatchQueue.main.async {
            let viewController = Container.shared.editPersonalDetailsBuilder().build(me: me)
            viewController.delegate = self.viewController
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func goToEditSocialMediaDetails(me: User) {
        DispatchQueue.main.async {
            let viewController = Container.shared.editSocialMediasBuilder().build(me: me)
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func goToChangePassword(me: User) {
        DispatchQueue.main.async {
            let viewController = Container.shared.changePasswordBuilder().build(me: me)
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func goToBlockedUsers() {
        DispatchQueue.main.async {
            let viewController = Container.shared.blockedUsersBuilder().build()
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func goToTermsAndConditions() {
        DispatchQueue.main.async {
            let viewController = Container.shared.termsAndConditionsBuilder().build()
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func changeRootToStartup() {
        DispatchQueue.main.async {
            let viewController = Container.shared.startupBuilder().build().embeddedInNavigation()
            changeRoot(to: viewController)
        }
    }
}
