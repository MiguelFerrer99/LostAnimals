//
//  ProfileSettingsProtocols.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 10/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

extension ProfileSettingsViewController: ActionAfterSelectPhotoDelegate {
    // MARK: - ActionAfterSelectPhotoDelegate
    func goTo(action: ActionAfterSelectPhoto) {
        switch action {
        case .removePhoto: removePhoto()
        case .choosePhoto: choosePhoto()
        case .takePhoto:   takePhoto()
        }
    }
}
