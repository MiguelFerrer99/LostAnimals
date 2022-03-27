//
//  ProfileSettingsViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 25/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Enums
enum ProfileSettingsImageType: String {
    case header
    case user
}

final class ProfileSettingsViewModel {
    // MARK: - Properties
    private let router: ProfileSettingsRouter
    var selectedImageView: ProfileSettingsImageType = .user
    let me: User
    
    // MARK: - AuthenticationService
    let authenticationService = AuthenticationService()
    
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
    
    func didPressedChangeHeaderImageButton(headerImage: UIImage) {
        selectedImageView = .header
        self.router.goToSelectPhotoPopup(showRemoveOption: !headerImage.isEqualTo(image: UIImage(named: "DefaultHeaderImage")))
    }
    
    func didPressedChangeProfileImageButton(profileImage: UIImage) {
        selectedImageView = .user
        self.router.goToSelectPhotoPopup(showRemoveOption: !profileImage.isEqualTo(image: UIImage(named: "DefaultUserImage")))
    }
    
    func didPressedEditPersonalDataButton() {
        self.router.goToEditPersonalDetails(me: me)
    }
    
    func didPressedEditSocialMediaButton() {
        self.router.goToEditSocialMediaDetails(me: me)
    }
    
    func didPressedChangePasswordButton() {
        self.router.goToChangePassword(me: me)
    }
    
    func didPressedBlockedUsersButton() {
        self.router.goToBlockedUsers()
    }
    
    func didPressedTermsAndConditionsButton() {
        self.router.goToTermsAndConditions()
    }
    
    func didPressedDeleteAccountButton(yesButtonPressed: @escaping (() -> ())) {
        showConfirmationPopup(title: "Are you sure you want to delete your account?") {
            yesButtonPressed()
            self.authenticationService.deleteAccount(id: self.me.id) { result in
                switch result {
                case .success:
                    Cache.logOut()
                    self.router.changeRootToStartup()
                case .error(let error):
                    showErrorPopup(title: error)
                }
            }
        }
    }
    
    func didPressedLogoutButton(yesButtonPressed: @escaping (() -> ())) {
        showConfirmationPopup(title: "Are you sure you want to logout?") {
            yesButtonPressed()
            self.authenticationService.logOut { result in
                switch result {
                case .success:
                    Cache.logOut()
                    self.router.changeRootToStartup()
                case .error(let error):
                    showErrorPopup(title: error)
                }
            }
        }
    }
}
