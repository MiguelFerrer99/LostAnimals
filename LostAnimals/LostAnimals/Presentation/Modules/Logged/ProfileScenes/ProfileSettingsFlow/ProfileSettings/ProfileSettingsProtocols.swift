//
//  ProfileSettingsProtocols.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 10/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

// MARK: - ActionAfterSelectPhotoDelegate
extension ProfileSettingsViewController: ActionAfterSelectPhotoDelegate {
    func goTo(action: ActionAfterSelectPhoto) {
        switch action {
        case .removePhoto: removePhoto()
        case .choosePhoto: choosePhoto()
        case .takePhoto:   takePhoto()
        }
    }
}

// MARK: - EditPersonalDetailsDelegate
extension ProfileSettingsViewController: EditPersonalDetailsDelegate {
    func updatePersonalDetails() {
        delegate?.updatePersonalDetails()
    }
}

// MARK: - EditSocialMediasDelegate
extension ProfileSettingsViewController: EditSocialMediasDelegate {
    func updateSocialMedias() {
        guard let me = User.shared else { return }
        viewModel.me = me
        delegate?.updateSocialMediasDetails()
    }
}

// MARK: - BlockedUsersDelegate
extension ProfileSettingsViewController: BlockedUsersDelegate {
    func updateBlockedUsersButtonView() {
        updateBlockedUsersView()
    }
}
