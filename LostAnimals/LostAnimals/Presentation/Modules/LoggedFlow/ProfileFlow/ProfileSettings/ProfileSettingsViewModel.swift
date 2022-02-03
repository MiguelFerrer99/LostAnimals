//
//  ProfileSettingsViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 25/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

final class ProfileSettingsViewModel {
    
    // MARK: - Properties
    private let router: ProfileSettingsRouter
    let me: User
    
    // MARK: - Init
    required init(router: ProfileSettingsRouter, me: User) {
        self.router = router
        self.me = me
    }
}

// MARK: - Life cycle
extension ProfileSettingsViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension ProfileSettingsViewModel {
    func didPressedBackButton() {
        self.router.goBack()
    }
    
    func didPressedChangeHeaderImageButton() {
        // TODO: - Open SelectPhotoPopup
    }
    
    func didPressedChangeProfileImageButton() {
        // TODO: - Open SelectPhotoPopup
    }
    
    func didPressedEditPersonalDataButton() {
        self.router.goToEditPersonalData()
    }
    
    func didPressedEditSocialMediaButton() {
        self.router.goToEditSocialMedias()
    }
    
    func didPressedChangePasswordButton() {
        self.router.goToChangePassword()
    }
    
    func didPressedBlockedUsersButton() {
        self.router.goToBlockedUsers()
    }
    
    func didPressedTermsAndConditionsButton() {
        self.router.goToTermsAndConditions()
    }
    
    func didPressedLogoutButton() {
        Cache.logOut()
        self.router.changeRootToStartup()
    }
}
