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
    
    // MARK: - Functions
    func goBack() {
        DispatchQueue.main.async {
            self.viewController?.pop()
        }
    }
    
    func goToSelectPhotoPopup(showRemoveOption: Bool) {
        let viewController = Container.shared.selectPhotoPopupBuilder().build(showRemoveOption: showRemoveOption, comesFrom: .profileSettings)
        viewController.delegate = self.viewController
        DispatchQueue.main.async {
            self.viewController?.present(viewController: viewController, completion: nil)
        }
    }
    
    func goToEditPersonalDetails(me: User) {
        let viewController = Container.shared.editPersonalDetailsBuilder().build(me: me)
        DispatchQueue.main.async {
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func goToEditSocialMediaDetails(me: User) {
        let viewController = Container.shared.editSocialMediasBuilder().build(me: me)
        DispatchQueue.main.async {
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func goToChangePassword(me: User) {
        let viewController = Container.shared.changePasswordBuilder().build(me: me)
        DispatchQueue.main.async {
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func goToBlockedUsers() {
        let viewController = Container.shared.blockedUsersBuilder().build()
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
    
    func changeRootToStartup() {
        let viewController = Container.shared.startupBuilder().build().embeddedInNavigation()
        DispatchQueue.main.async {
            changeRoot(to: viewController)
        }
    }
}
