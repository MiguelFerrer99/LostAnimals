//
//  ProfileProtocols.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 5/6/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - ProfileSettingsDelegate
extension ProfileViewController: ProfileSettingsDelegate {
    func updateHeaderImage() {
        reloadHeaderImage()
    }
    
    func updateUserImage() {
        reloadUserImage()
    }
    
    func updatePersonalDetails() {
        reloadBasicInfo()
    }
    
    func updateSocialMediasDetails() {
        reloadSocialMedias()
    }
}

// MARK: - MyPetDelegate
extension ProfileViewController: MyPetDelegate {
    func updateMyPet() {
        reloadMyPet()
    }
    
    func openNewPost(postToLoad: Post, imagesToLoad: [UIImage]) {
        viewModel.openNewPost(postToLoad: postToLoad, imagesToLoad: imagesToLoad)
    }
}
