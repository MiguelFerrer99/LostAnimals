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

// MARK: - Typealias
typealias ProfileImages = (userImage: UIImage?, headerImage: UIImage?)

final class ProfileSettingsViewModel {
    // MARK: - Properties
    private let router: ProfileSettingsRouter
    var me: User
    let profileImages: ProfileImages
    var selectedImageView: ProfileSettingsImageType = .user
    var userIsModified = false
    
    // MARK: - Services
    let userService = UserService()
    
    // MARK: - Init
    required init(router: ProfileSettingsRouter, me: User, images: ProfileImages) {
        self.router = router
        self.me = me
        self.profileImages = images
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
    
    func didPressedRemovePhoto(completion: @escaping ((GenericResult) -> ())) {
        userService.editUserImage(newImage: nil, imageType: selectedImageView) { result in
            switch result {
            case .success: completion(result)
            case .error(let error):
                completion(result)
                showErrorPopup(title: error)
            }
        }
    }
    
    func didPressedChangePhoto(newImage: UIImage, completion: @escaping ((GenericResult) -> ())) {
        userService.editUserImage(newImage: newImage, imageType: selectedImageView) { result in
            switch result {
            case .success: completion(result)
            case .error(let error):
                completion(result)
                showErrorPopup(title: error)
            }
        }
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
    
    func didPressedDeleteAccountButton() {
        showConfirmationPopup(title: .ProfileSettings.AreYouSureDeleteAccount()) {
            showConfirmPasswordPopup {
                self.router.changeRootToStartup()
            }
        }
    }
    
    func didPressedLogoutButton(yesButtonPressed: @escaping (() -> ()), completion: @escaping (() -> ())) {
        showConfirmationPopup(title: .ProfileSettings.AreYouSureLogOut()) {
            yesButtonPressed()
            self.userService.logOut { result in
                completion()
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
